class AddIndexChanGroups < ActiveRecord::Migration
  def change
    add_index :chan_groups, :chan_group_name, :unique => true
  end
end
