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

class PrefixGroup < ActiveRecord::Base
  has_many :prefixes
  has_many :chan_prefix_groups
  has_many :channels, :through => :chan_prefix_groups
  has_many :cdrs

  attr_accessible :group_name, :def_init_charge, :def_minutes_per_day, :def_rate, :color, :member_book_size, :member_age_hours

  validates :group_name, :uniqueness => true, :allow_blank => false
  validates :def_rate, :def_init_charge, :def_minutes_per_day, :numericality => true

  def prefixes_list
    self.prefixes.map(&:prefix)
  end
end
