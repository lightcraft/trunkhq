class ChangePrefixGroup < ActiveRecord::Migration
  def up
    rename_column :prefix_groups, :rate, :def_rate
    rename_column :prefix_groups, :init_charge, :def_init_charge
    rename_column :prefix_groups, :minutes_per_day, :def_minutes_per_day
  end

  def down
    rename_column :prefix_groups, :def_rate, :rate
    rename_column :prefix_groups, :def_init_charge, :init_charge
    rename_column :prefix_groups, :def_minutes_per_day, :minutes_per_day
  end
end
