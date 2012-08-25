class CreateChanGroups < ActiveRecord::Migration
  def change
    create_table :chan_groups do |t|
      t.string :chan_group_name

      t.timestamps
    end
    add_index :chan_groups, :chan_group_name, :unique => true
  end
end
