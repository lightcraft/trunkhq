# == Schema Information
#
# Table name: prefixes
#
#  id              :integer          not null, primary key
#  prefix_group_id :integer
#  prefix          :string(200)
#

class Prefix < ActiveRecord::Base
  belongs_to :prefix_group
  attr_accessible :prefix_group, :prefix

end
