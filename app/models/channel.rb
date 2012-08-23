class Channel < ActiveRecord::Base
  belongs_to :location
  belongs_to :sip
  belongs_to :chan_group

  self.table_name = 'channels'

  attr_accessible :group_id, :location_id, :password, :phone_number, :start_date, :start_time, :stop_date, :stop_time, :operator
  attr_accessor :operator

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
