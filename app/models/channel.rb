class Channel < ActiveRecord::Base
  self.table_name = 'channels'
  STATUS = {1 => 'ON', 2 => 'OFF', 3 => 'Paused', 4 => 'Alarm', 5 => 'Timeout', nil => 'not registred'}

  belongs_to :location
  belongs_to :sip
  belongs_to :chan_group
  has_many :chan_prefix_groups, dependent: :destroy
  has_many :prefix_groups, through: :chan_prefix_groups
  has_many :cdrs
  has_one :active_call

  validates :chan_group_id, presence: true
  validates :location_id, presence: true

  attr_accessible :chan_group_id, :location_id, :start_date, :start_time, :stop_date, :stop_time, :imei
  accepts_nested_attributes_for :chan_prefix_groups
  accepts_nested_attributes_for :sip
  attr_accessible :sip_attributes
  attr_accessible :chan_prefix_groups_attributes

  scope :on, where(status: 1)
  scope :off, where(status: 2)
  scope :paused, where(status: 3)
  scope :alarm, where(status: 4)

  after_destroy { |record| Sip.destroy_all "sip.id = #{record.sip_id}" }
  delegate :name, :to => :sip
  delegate :secret, :to => :sip

  before_save { |record|
    self.init_date = Date.today if record.start_date_changed?
    self.status = 1 if record.new_record?
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
    if self.status.eql?(1) && self.active_call
      sec = (self.active_call.start_time - Time.now).to_i
      addtional = " Incall #{self.active_call.dst}/#{sec} s"
    end
    Channel::STATUS[self.status] + addtional
  end

  #  #$diff = $row2['sip.regseconds'] - time();
  #$diff > 0  - ONLINE
  #$diff < 0  - OFFLINE
  def online_status
    (self.sip.regseconds - Time.now.to_i) > 0 ?
        'Online' :
        'Offline'
  end

  # Play path from public directory
  def audio_path
    #TODO change path after Yura send information
    "/audio/success.wav"
  end

  # returned
  # [{prefix_group_id => prefix_group_name}]
  def operator_groups
    self.prefix_groups.includes(:chan_prefix_groups).where('chan_prefix_groups.enabled = ?', true)
  end

  def state_on
    self.update_attribute(:status, 1) unless self.status.eql?(1)
  end

  def sys_info
    {useragent: self.sip.useragent, regseconds: self.sip.regseconds, fullcontact: self.sip.fullcontact}
  end

  def system_status
    #allow: ulaw;alaw;gsm;
    #fullcontact: sip:204018@213.231.6.254:7074
    #ipaddr: 213.231.6.254
    #port: 7074
    #regserver: ''
    #regseconds: 1347120641
    #lastms: 44

    [self.sip.fullcontact,
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

  # {prefix_group_id -> bill_time}
  #{nil=>0, 1=>0, 2=>307}
  #
  def today_bill_time
    self.cdrs.group(:prefix_group_id).today.sum('billsec/60')
  end
end
