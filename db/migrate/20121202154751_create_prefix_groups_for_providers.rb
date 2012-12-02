class CreatePrefixGroupsForProviders < ActiveRecord::Migration
  def change
    unless ActiveRecord::Base.connection.table_exists? 'prefix_groups_for_provider'
      create_table :prefix_groups_for_providers do |t|
        t.string :group_name
        t.decimal :def_rate
        t.decimal :def_init_charge
        t.integer :def_minutes_per_day
        t.string :color

        t.timestamps
      end
    end
  end
end
