class AddColumnsToUserPrefixGroup < ActiveRecord::Migration
  def change
    change_table :user_prefix_groups do |t|
      t.string :rate
      t.integer :init_charge
    end
  end
end
