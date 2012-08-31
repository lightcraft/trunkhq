require 'securerandom'

class Provider < User
  rolify
  has_and_belongs_to_many :roles, :join_table => :users_roles, :foreign_key => 'user_id'

  #has_many :user_prefix_groups, :foreign_key => :user_id, dependent: :destroy
  #has_many :prefix_groups, through: :user_prefix_groups

  #accepts_nested_attributes_for :user_prefix_groups
  #attr_accessible :user_prefix_groups_attributes
  validates_presence_of :name
  attr_accessible :email, :name
  attr_accessor :class_name

  before_validation :stub_attributes, :on => :create
  after_create :auto_subscribe

  def operator_limits
    self.user_prefix_groups.includes(:prefix_group).collect { |user_prefix_group|
      "#{user_prefix_group.prefix_group.group_name} (#{user_prefix_group.allowed_minutes}/#{user_prefix_group.rate})"
    }.join(', ')
  end

  private
  def stub_attributes
    self.class_name = self.class.name
    self.password = SecureRandom.urlsafe_base64(10)
    self.password_confirmation = self.password
  end

  def auto_subscribe
    self.add_role :provider
  end

end
