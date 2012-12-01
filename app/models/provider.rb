# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  login                  :string(15)
#  password               :string(15)
#  company                :string(100)      default("Private")
#  company_logo           :string(100)      default("/img/bird.gif")
#  application_name       :string(100)      default("Telefony")
#  last_login             :datetime
#  email                  :string(60)
#  role_id                :integer
#  encrypted_password     :string(255)      default("")
#  name                   :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0)
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  created_at             :datetime
#  updated_at             :datetime
#  confirmation_token     :string(255)
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string(255)
#  invitation_token       :string(60)
#  invitation_sent_at     :datetime
#  invitation_accepted_at :datetime
#  invitation_limit       :integer          default(3), not null
#  invited_by_id          :integer
#  invited_by_type        :string(255)
#  can_add_friendgroups   :boolean
#  provider_ip_address    :string(255)
#

require 'securerandom'

class Provider < User
  rolify
  has_and_belongs_to_many :roles, :join_table => :users_roles, :foreign_key => 'user_id'

  #has_many :user_prefix_groups, :foreign_key => :user_id, dependent: :destroy
  #has_many :prefix_groups, through: :user_prefix_groups

  #accepts_nested_attributes_for :user_prefix_groups
  #attr_accessible :user_prefix_groups_attributes
  validates_presence_of :name
  attr_accessible :email, :name, :provider_ip_address
  attr_accessor :class_name

  before_validation :stub_attributes, :on => :create
  after_create :auto_subscribe
  after_update :update_sip_settings

  def operator_limits
    self.user_prefix_groups.includes(:prefix_group).collect { |user_prefix_group|
      "#{user_prefix_group.prefix_group.group_name} (#{user_prefix_group.allowed_minutes}/#{user_prefix_group.rate})" if user_prefix_group.prefix_group
    }.join(', ')
  end

  def report(from = Time.now, to = Time.now)
    logger.info("-->  Provider Report")
    Cdr.where(:user_id => self.id).where('calldate > ? AND calldate < ?', from, to).group(:prefix_group_id).sum('billsec/60')
  end

  private
  def stub_attributes
    self.class_name = self.class.name
    self.password = SecureRandom.urlsafe_base64(10)
    self.password_confirmation = self.password
  end

  # we need add sip gateway when created provider
  def auto_subscribe
    self.add_role :provider

    Sip.create(name: self.name,
               host: self.provider_ip_address,
               accountcode: self.id,
               user_id: self.id,
               type: 'peer',
               context: 'default')
  end

  #we need update provider setting when admin change it
  def update_sip_settings
    provider_sip = Sip.where(accountcode: self.id).first
    provider_sip.update_attributes(
        name: self.name,
        host: self.provider_ip_address
    )
  end
end
