class Location < ActiveRecord::Base
  attr_accessible :name, :order
  belongs_to :user
  has_many :channels, :dependent => :destroy

  validates :user, :name, :presence => true

end
