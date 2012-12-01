# == Schema Information
#
# Table name: user_prefix_groups
#
#  id              :integer          not null, primary key
#  user_id         :integer
#  prefix_group_id :integer
#  allowed_minutes :integer
#  init_date       :date
#  rate            :string(255)
#  init_charge     :integer
#

class UserPrefixGroup < ActiveRecord::Base
  # поставщики услуг
  #belongs_to :provider, :foreign_key => 'user_id'#, :class_name => "User", :foreign_key => "user_id"
  belongs_to :user

  belongs_to :prefix_group

  attr_accessible :user_id, :prefix_group_id, :allowed_minutes, :init_charge, :init_date, :rate, :name, :provider

  validates :prefix_group_id, :presence => false
  validates_numericality_of :allowed_minutes, :greater_than_or_equal_to => 0, :allow_blank => false
  validates_numericality_of :rate, :greater_than_or_equal_to => 0, :allow_blank => false
  validates_uniqueness_of :user_id, :scope => :prefix_group_id

  attr_accessor :name

  delegate :group_name, :to => :prefix_group
  alias :name :group_name

end
