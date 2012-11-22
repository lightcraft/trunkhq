class CreateFriendGroups < ActiveRecord::Migration
  def change
    create_table :friend_groups do |t|
      t.string :name
      t.references :user

      t.timestamps
    end
  end
end
