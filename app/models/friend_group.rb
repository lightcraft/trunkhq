# == Schema Information
#
# Table name: friend_groups
#
#  id               :integer          not null, primary key
#  name             :string(255)
#  user_id          :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  min_duration_sec :integer
#  max_duration_sec :integer
#  calls_per_hour   :integer
#

class FriendGroup < ActiveRecord::Base
  attr_accessible :name, :min_duration_sec, :max_duration_sec, :calls_per_hour
  belongs_to :user

  validates :user, presence: true
  validates :name, presence: true, uniqueness: true
end
