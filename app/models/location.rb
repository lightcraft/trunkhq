# == Schema Information
#
# Table name: locations
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  order      :integer
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Location < ActiveRecord::Base
  attr_accessible :name, :order
  belongs_to :user
  has_many :channels, :dependent => :destroy
  has_many :cdrs

  validates :user, :name, :presence => true

end

#  WHERE location_id = #{location_id} AND datediff(curdate(),calldate) = 0
