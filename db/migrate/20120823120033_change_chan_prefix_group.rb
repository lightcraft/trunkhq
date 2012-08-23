class ChangeChanPrefixGroup < ActiveRecord::Migration
  def up
    change_table :chan_prefix_groups do |t|
      t.integer :interval_mins
      t.integer :calls_per_interval
      t.integer :call_min_interval
    end
  end

  def down
    change_table :chan_prefix_groups do |t|
      t.remove :interval_mins
      t.remove :calls_per_interval
      t.remove :call_min_interval
    end
  end
end
