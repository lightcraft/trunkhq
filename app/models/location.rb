class Location < ActiveRecord::Base
  attr_accessible :name, :order
  belongs_to :user
  has_many :channels, :dependent => :destroy
  has_many :cdrs

  validates :user, :name, :presence => true

end

#  WHERE location_id = #{location_id} AND datediff(curdate(),calldate) = 0