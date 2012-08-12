class Trunk < ActiveRecord::Base
  belongs_to :location

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
