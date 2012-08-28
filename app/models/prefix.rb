class Prefix < ActiveRecord::Base
  belongs_to :prefix_group
  attr_accessible :prefix_group, :prefix

end