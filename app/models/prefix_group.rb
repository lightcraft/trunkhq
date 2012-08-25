class PrefixGroup < ActiveRecord::Base
  has_many :prefixes
  has_many :chan_prefix_groups

  attr_accessible :group_name, :def_init_charge, :def_minutes_per_day, :def_rate

  validates :group_name, :uniqueness => true, :allow_blank => false
  validates :def_rate, :def_init_charge, :def_minutes_per_day, :numericality => true

end
