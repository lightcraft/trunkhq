class AddFriendGroupReferenceToChannel < ActiveRecord::Migration
  def change
    add_column :channels, :friend_group_id, :integer
    add_index :channels, :friend_group_id
  end
end
