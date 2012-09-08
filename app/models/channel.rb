class Channel < ActiveRecord::Base
  self.table_name = 'channels'
  STATUS = {1 => 'ON', 2 => 'OFF', 3 => 'Paused', 4 => 'Alarm', nil => 'not registred'}

  belongs_to :location
  belongs_to :sip
  belongs_to :chan_group
  has_many :chan_prefix_groups, dependent: :destroy
  has_many :prefix_groups, through: :chan_prefix_groups

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
    Channel::STATUS[self.status]
  end

  def subscribecontext
    self.sip.subscribecontext
  end

  def operator_groups
    self.chan_prefix_groups.includes(:prefix_group).where(enabled: true).map(&:name).join(', ')
  end

  def state_on
    self.update_attribute(:status, 1) unless self.status.eql?(1)
  end

  def sys_info
    {useragent: self.sip.useragent, regseconds: self.sip.regseconds, fullcontact: self.sip.fullcontact}
  end

  def build_prefix_groups
    ids = self.prefix_group_ids

    prefix_groups = PrefixGroup.order(:group_name)
    prefix_groups = prefix_groups.where(['id NOT IN (?)', ids])  unless ids.blank?

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
end
