# == Schema Information
#
# Table name: user_prefix_groups
#
#  id              :integer          not null, primary key
#  user_id         :integer
#  prefix_group_id :integer
#  allowed_minutes :integer
#  start_date       :date
#  rate            :string(255)
#  init_charge     :integer
#  enabled         :boolean

class UserPrefixGroup < ActiveRecord::Base
  # поставщики услуг
  #belongs_to :provider, :foreign_key => 'user_id'#, :class_name => "User", :foreign_key => "user_id"
  belongs_to :user

 # belongs_to :prefix_group
  belongs_to :prefix_groups_for_provider
  attr_accessible :user_id, :prefix_groups_for_provider_id, :allowed_minutes, :init_charge, :start_date, :rate, :name, :provider, :enabled

  validates :prefix_groups_for_provider_id, :presence => false
  validates_numericality_of :allowed_minutes, :greater_than_or_equal_to => 0, :allow_blank => false
  validates_numericality_of :rate, :greater_than_or_equal_to => 0, :allow_blank => false
  validates_uniqueness_of :user_id, :scope => :prefix_groups_for_provider_id

  attr_accessor :name

  delegate :group_name, :to => :prefix_groups_for_provider
  alias :name :group_name

end
