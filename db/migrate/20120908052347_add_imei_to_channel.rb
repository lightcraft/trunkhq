class AddImeiToChannel < ActiveRecord::Migration
  def change
    change_table :channels do |t|
      t.string :imei, :limit => 20, :default => "", :null => false
    end
  end
end
