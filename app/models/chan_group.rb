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

class ChanGroup < ActiveRecord::Base
  has_many :channels

  attr_accessible :chan_group_name, :max_channels_cnt, :max_channels_online

  validates :chan_group_name, :allow_blank => false, :uniqueness => true
  validates :max_channels_cnt, :max_channels_online, :numericality => true, :allow_nil => false

  def name
    self.chan_group_name
  end
end
