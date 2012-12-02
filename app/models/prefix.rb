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
  belongs_to :prefix_groups_for_provider
  attr_accessible :prefix_group, :prefix_groups_for_provider, :prefix, :prefix_group_id, :prefix_groups_for_provider_id

end
