class AddWmzToUser < ActiveRecord::Migration
  def up
    add_column :users, :wmz, :string
    remove_column :users, :login, :password rescue nil
  end
end
