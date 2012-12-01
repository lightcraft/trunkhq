# == Schema Information
#
# Table name: active_calls
#
#  id                  :integer          not null, primary key
#  uniqueid            :string(32)
#  channel_id          :integer
#  user_id             :integer
#  sip_id              :integer
#  provider_account_id :integer
#  start_time          :datetime
#  src                 :string(25)
#  dst                 :string(25)
#  max_duration        :integer
#  prefix_group_id     :integer
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#

class ActiveCall < ActiveRecord::Base
  belongs_to :channel
  # attr_accessible :title, :body
end
