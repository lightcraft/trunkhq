class AddColumnsToFriends < ActiveRecord::Migration
  def up
    add_column :friend_groups, :min_duration_sec, :integer
    add_column :friend_groups, :max_duration_sec, :integer
    add_column :friend_groups, :calls_per_hour, :integer
  end

  def down
    remove_column  :friend_groups, :min_duration_sec, :max_duration_sec, :calls_per_hour
  end
end
