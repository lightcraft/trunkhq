class AddColumnsToChanPrefixGroup < ActiveRecord::Migration
  def change
    change_table :chan_prefix_groups do |t|
      t.column(:strict, :boolean)
      t.column(:enabled, :boolean)
    end
  end
end
