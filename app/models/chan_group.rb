class ChanGroup < ActiveRecord::Base
  has_many :channels

  attr_accessible :chan_group_name, :max_channels_cnt, :max_channels_online

  validates :chan_group_name, :allow_blank => false, :uniqueness => true
  validates :max_channels_cnt, :max_channels_online, :numericality => true, :allow_nil => false

end
