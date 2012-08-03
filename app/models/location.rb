class Location < ActiveRecord::Base
  attr_accessible :name, :order
  belongs_to :user
  has_many :trunks

  validates :user, :name, :presence => true

end
