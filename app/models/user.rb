class User < ActiveRecord::Base
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

  after_create :create_user_home
  after_invitation_accepted :email_invited_by


  def create_user_home
    self.locations << Location.new(name: 'Home')
  end

  def email_invited_by
    User.find(self.invited_by_id).decrement!(:invitation_limit)
  end

  def can_create_invitation?
    self.invitation_limit.to_i > 0
  end
end
