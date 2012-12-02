class PrefixGroupsForProvider < ActiveRecord::Base
  attr_accessible :color, :def_init_charge, :def_minutes_per_day, :def_rate, :group_name
  has_many :prefixes

  validates :group_name, :uniqueness => true, :allow_blank => false
  validates :def_rate, :def_init_charge, :def_minutes_per_day, :numericality => true

  def prefixes_list
    self.prefixes.map(&:prefix)
  end
end
