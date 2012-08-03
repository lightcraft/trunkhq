class CreateTrunks < ActiveRecord::Migration
  def change
    create_table :trunks do |t|
      t.string :phone_number
      t.string :password
      t.integer :location_id
      t.integer :group_id
      t.date :start_date
      t.date :stop_date
      t.time :start_time
      t.time :stop_time

      t.timestamps
    end
  end
end
