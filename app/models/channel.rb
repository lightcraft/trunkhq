# == Schema Information
#
# Table name: channels
#
#  id              :integer          not null, primary key
#  sip_id          :integer
#  status          :integer
#  timeout_expire  :datetime
#  timeout_reason  :string(255)
#  chan_group_id   :integer
#  location_id     :integer
#  init_date       :date
#  start_date      :date
#  stop_date       :date
#  start_time      :time
#  stop_time       :time
#  created_at      :datetime
#  updated_at      :datetime
#  name            :string(100)
#  imei            :string(20)
#  gsm_number      :string(60)
#  friend_group_id :integer
#

class Channel < ActiveRecord::Base
  self.table_name = 'channels'

  STATUS = {1 => 'ON',
            2 => 'OFF',
            3 => '<span class="badge badge-important">ALARM</span>',
            4 => '<span class="badge badge-important">Alarm<span>',
            5 => 'Timeout',
            nil => 'not registred'}

  belongs_to :location
  belongs_to :sip
  belongs_to :chan_group
  belongs_to :friend_group
  has_many :chan_prefix_groups, dependent: :destroy
  has_many :prefix_groups, through: :chan_prefix_groups
  has_many :cdrs
  has_one :active_call

  validates :chan_group_id, presence: true
  validates :location_id, presence: true

  attr_accessible :chan_group_id, :location_id, :start_date, :start_time, :stop_date, :stop_time, :imei, :gsm_number
  accepts_nested_attributes_for :chan_prefix_groups
  accepts_nested_attributes_for :sip
  attr_accessible :sip_attributes
  attr_accessible :chan_prefix_groups_attributes

  scope :on, where(status: 1)
  scope :off, where(status: 2)
  scope :paused, where(status: 3)
  scope :alarm, where(status: 4)

  after_destroy { |record| Sip.destroy_all "sip.id = #{record.sip_id}" }
#  delegate :name, :to => :sip
  delegate :secret, :to => :sip

  before_save { |record|
    self.init_date = Date.today if record.start_date_changed?
    self.status = 2 if record.new_record?
    self.sip.update_attribute(:name, self.name)
  }

  after_create { |record|
    self.update_attribute(:name, sprintf("%03d%03d", record.location.user_id, record.id))
  }

  def start_date_str
    (self.start_date || Date.today).to_s(:date)
  end

  def stop_date_str
    (self.stop_date.blank? ? Date.today + 14.days : self.stop_date).to_s(:date)
  end

  def state
    # timeout_expired
    # timeout_reson
    # ON  - звонок status 1
    # -> active_calls.channel_id
    # active_calls.start_time  - current_time  -> длительность звонка
    addtional = ''

    self.reload
    if online?
      if self.active_call(true)
        sec = (Time.current - self.active_call.start_time).to_i
        min = (sec/60).round
        sec = sec - min * 60
        # модем в состоянии звонка
        direction = self.active_call.provider_account_id < 0 ? " <span style='color:yellow'>SOFTPHONE-CALL</span>" : ""
        direction = self.active_call.provider_account_id > 0 ? " <span style='color:blue'>OUTBOUND-CALL</span>" : direction
        direction = self.active_call.provider_account_id == 0 ? " <span style='color:brown'>INBOUND-CALL</span>" : direction

        addtional << " #{direction} #{self.active_call.dst}/ #{min}:#{sec}s"
      elsif self.active_call(true).blank?
        time_diff = self.timeout_expire ? (self.timeout_expire - Time.current).to_i : 0
        # addtional << "<span title='time_diff #{time_diff}  expire_time #{self.timeout_expire } Time.current #{Time.current}' > t </span>"
        if time_diff > 0
          min = (time_diff/60).round
          sec = time_diff - min * 60
          addtional << " <span title='#{self.timeout_reason} #{min}:#{sec}' >?</span>"
        else
          addtional << " <span title='Chanel free'>Free</span>"
        end
      end
    else
      addtional << ' <span style="color:red" title="Modem is not registered">OFFLINE</span>'
    end
    Channel::STATUS[self.status].to_s + addtional.to_s
  end

  def state_css
   self.sip && (self.sip.regseconds - Time.current.to_i) > 0 ?
        'badge-success' :
        'badge-important'
  end

#  #$diff = $row2['sip.regseconds'] - time();
#$diff > 0  - ONLINE
#$diff < 0  - OFFLINE
  def online_status
    online? ?
        'Online' :
        'Offline'
  end

  def online?
    self.sip &&
        (self.sip.regseconds - Time.current.to_i) > 0
  end

# Play path from public directory
  def audio_path
    '/monitor/'+Cdr.lact_call_ident(self)+'.ogg'
  end

# returned
# [{prefix_group_id => prefix_group_name}]
  def operator_groups
    self.prefix_groups.includes(:chan_prefix_groups).where('chan_prefix_groups.enabled = ?', true)
  end

  def state_toggle
    self.status.eql?(1) ?
        self.update_attribute(:status, 2) :
        self.update_attribute(:status, 1)
  end

  def sys_info
    {useragent: self.sip.useragent, regseconds: (self.sip && self.sip.regseconds) || 0, fullcontact: self.sip.fullcontact}
  end

  def reset_state
    self.update_column(:status, 5) # set status 5 and should be called DB trigger that reset start date and etc..
  end

  def system_status
    #allow: ulaw;alaw;gsm;
    #fullcontact: sip:204018@213.231.6.254:7074
    #ipaddr: 213.231.6.254
    #port: 7074
    #regserver: ''
    #regseconds: 1347120641
    #lastms: 44

    [self.sip.fullcontact.split('^3B').first,
     self.sip.useragent,
     "IP: #{sip.ipaddr}"]
  end

  def build_prefix_groups
    ids = self.prefix_group_ids

    prefix_groups = PrefixGroup.order(:group_name)
    prefix_groups = prefix_groups.where(['id NOT IN (?)', ids]) unless ids.blank?

    groups = prefix_groups.collect { |group| {
        name: group.group_name,
        call_min_interval: 60,
        calls_per_interval: 2,
        interval_mins: 60,
        prefix_group_id: group.id,
        max_minutes_per_day: group.def_minutes_per_day,
    } }
    self.chan_prefix_groups.build(groups)
  end

  def duration_today
    # вывести минуты и секунды
    #=> {"billsec"=>654, "rows"=>14}

    #sec = self.cdrs.today.sum('billsec').to_i # -> sec
    self.cdrs.today.select("SUM(`cdr`.`billsec`) AS billsec, COUNT(*) as rows ").first.attributes
  end

# {prefix_group_id -> bill_time}
#{nil=>0, 1=>0, 2=>307}
#
  def today_bill_time
    self.cdrs.group(:prefix_group_id).today.sum('billsec')
  end

end
