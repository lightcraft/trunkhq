# == Schema Information
#
# Table name: prefix_groups
#
#  id                  :integer          not null, primary key
#  group_name          :string(255)
#  def_rate            :decimal(10, 4)
#  def_init_charge     :decimal(10, 4)
#  def_minutes_per_day :integer
#  color               :string(255)      default(""), not null
#

require 'spec_helper'

describe PrefixGroup do
  pending "add some examples to (or delete) #{__FILE__}"
end
