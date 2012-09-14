class AddColorColumnToPrefixGroup < ActiveRecord::Migration

  def change
    change_table :prefix_groups do |t|
      t.string :color, :null => false, :default => ""
    end
  end

end
