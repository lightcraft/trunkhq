class Trunk < ActiveRecord::Base
  belongs_to :location

  attr_accessible :group_id, :location_id, :password, :phone_number, :start_date, :start_time, :stop_date, :stop_time, :operator
  attr_accessor :operator
end
