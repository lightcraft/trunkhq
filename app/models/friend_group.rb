class FriendGroup < ActiveRecord::Base
  attr_accessible :name

  belongs_to :user

  validates :user, presence: true
  validates :name, presence: true, uniqueness: true
end
