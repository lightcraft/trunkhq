class AddCanAddFriendgroupsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :can_add_friendgroups, :boolean
  end
end
