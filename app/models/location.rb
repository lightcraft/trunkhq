class Location < ActiveRecord::Base
  attr_accessible :name, :order
  belongs_to :user
  has_many :channels

  validates :user, :name, :presence => true

end
