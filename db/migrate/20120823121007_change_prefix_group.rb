class ChangePrefixGroup < ActiveRecord::Migration
  def up
    rename_column :chan_prefix_groups, :interval_mins, :def_interval_mins
    rename_column :chan_prefix_groups, :calls_per_interval, :def_calls_per_interval
    rename_column :chan_prefix_groups, :call_min_interval, :def_call_min_interval
  end

  def down
    rename_column :chan_prefix_groups, :def_interval_mins, :interval_mins
    rename_column :chan_prefix_groups, :def_calls_per_interval, :calls_per_interval
    rename_column :chan_prefix_groups, :def_call_min_interval, :call_min_interval
  end
end
