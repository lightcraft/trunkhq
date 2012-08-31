class Role < ActiveRecord::Base
  has_and_belongs_to_many :users, :join_table => :users_roles
  has_and_belongs_to_many :providers, :join_table => :users_roles
  belongs_to :resource, :polymorphic => true

  def self.first_admin
    self.where(name: 'admin').first.users.order(:id).first
  end
end
