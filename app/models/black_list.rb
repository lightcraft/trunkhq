# == Schema Information
#
# Table name: black_lists
#
#  id         :integer          not null, primary key
#  number     :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class BlackList < ActiveRecord::Base
  attr_accessible :number

  validates_presence_of :number
  validates_numericality_of :number
  validates_uniqueness_of :number
  validates_length_of :number, :minimum => 11, :maximum => 11

end
