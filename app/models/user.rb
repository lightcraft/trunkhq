class User < ActiveRecord::Base
  # login/password  - Unused
  rolify
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :name, :email, :password, :password_confirmation, :remember_me, :confirmed_at

  has_many :locations
  has_many :invitations, :class_name => 'User', :as => :invited_by

  has_many :user_prefix_groups, :foreign_key => :user_id, dependent: :destroy
  has_many :prefix_groups, through: :user_prefix_groups
  accepts_nested_attributes_for :user_prefix_groups
  attr_accessible :user_prefix_groups_attributes

  after_create :build_user_env
  after_invitation_accepted :email_invited_by

  def build_user_env
    if self.class_name.eql?('User')
      self.locations << Location.new(name: 'Home')
      self.add_role :user
    end
  end

  def email_invited_by
    User.find(self.invited_by_id).decrement!(:invitation_limit)
  end

  def can_create_invitation?
    self.invitation_limit.to_i > 0
  end

  def class_name
    self.class.name
  end
end
