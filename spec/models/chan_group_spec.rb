# == Schema Information
#
# Table name: chan_groups
#
#  id                  :integer          not null, primary key
#  chan_group_name     :string(50)
#  max_channels_cnt    :integer
#  max_channels_online :integer
#  user_id             :integer
#

require 'spec_helper'

describe ChanGroup do
  pending "add some examples to (or delete) #{__FILE__}"
end
