class Channel < ActiveRecord::Base
  belongs_to :location
  belongs_to :sip
  belongs_to :chan_group
  has_many :chan_prefix_groups
  #has_many :prefix_groups, :through => :chan_prefix_groups
  has_and_belongs_to_many :prefix_groups, :join_table => :chan_prefix_groups

  STATUS = {1 => 'ON', 2 =>'OFF', 3 => 'Paused', 4 => 'Alarm'}

  self.table_name = 'channels'

  attr_accessible :group_id, :location_id, :start_date, :start_time, :stop_date, :stop_time, :sip
  delegate :name, :secret, :to => :sip
  #alias_method :phone_number, :name
  #alias_method :password, :secret

  def start_date_str
    (self.start_date || Time.now).to_s(:date)
  end

  def stop_date_str
    (self.stop_date.blank? ? Time.now + 14.days : self.stop_date).to_s(:date)
  end

  def state
    'ON'
  end
end
