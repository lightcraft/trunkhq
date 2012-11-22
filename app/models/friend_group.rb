class FriendGroup < ActiveRecord::Base
  attr_accessible :name, :min_duration_sec, :max_duration_sec, :calls_per_hour
  belongs_to :user

  validates :user, presence: true
  validates :name, presence: true, uniqueness: true
end
