class ChangeCannels < ActiveRecord::Migration
  def up
    change_table :channels do |t|
      t.integer :location_id
      t.date :init_date
      t.date :start_date
      t.date :stop_date
      t.time :start_time
      t.time :stop_time
      t.remove :interval_mins
      t.remove :calls_per_interval
      t.remove :call_min_interval
      t.timestamps
    end
  end

  def down
    change_table :channels do |t|
      t.integer :interval_mins
      t.integer :calls_per_interval
      t.integer :call_min_interval
      t.remove :location_id
      t.remove :sip_id
      t.remove :init_date
      t.remove :start_date
      t.remove :stop_date
      t.remove :start_time
      t.remove :stop_time
      t.remove :create_at
      t.remove :updated_at
    end
  end
end
