class AddIpAddressToUser < ActiveRecord::Migration
  def up
    add_column :users, :provider_ip_address, :string
  end

  def down
    remove_column :users, :provider_ip_address, :string
  end
end
