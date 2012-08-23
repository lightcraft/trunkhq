class PrefixGroup < ActiveRecord::Base
  has_many :prefixes
  has_many :chan_prefix_groups

end