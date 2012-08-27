class UserPrefixGroup < ActiveRecord::Base
  # поставщики услуг
  belongs_to :user
  belongs_to :prefix_group

  attr_accessible :user_id, :prefix_group_id, :allowed_minutes, :init_charge, :init_date, :rate

  validates :user_id, :presence => true
  validates :prefix_group_id, :presence => false
  validates :allowed_minutes, :numericality => true
  validates_uniqueness_of :user_id, :scope => :prefix_group_id

end