class Location < ActiveRecord::Base
  attr_accessible :name, :order
  belongs_to :user
  validates :user, :presence => true

end
