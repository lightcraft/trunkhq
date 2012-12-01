# == Schema Information
#
# Table name: chan_prefix_groups
#
#  id                  :integer          not null, primary key
#  channel_id          :integer
#  prefix_group_id     :integer
#  max_minutes_per_day :integer
#  max_calls_per_day   :integer          default(0)
#  interval_mins       :integer
#  calls_per_interval  :integer
#  call_min_interval   :integer
#  strict              :boolean
#  enabled             :boolean
#

class ChanPrefixGroup < ActiveRecord::Base
  belongs_to :channel
  belongs_to :prefix_group
  attr_accessible :channel, :prefix_group, :prefix_group_id, :call_min_interval, :calls_per_interval,
                  :interval_mins, :max_minutes_per_day, :max_calls_per_day, :max_calls_per_day,
                  :name, :enabled, :strict

  validates :call_min_interval, :numericality => true
  validates :calls_per_interval, :numericality => true
  validates :interval_mins, :numericality => true
  validates :max_minutes_per_day, :numericality => true

  attr_accessor :name

  delegate :group_name, :to => :prefix_group
  alias :name :group_name

end
