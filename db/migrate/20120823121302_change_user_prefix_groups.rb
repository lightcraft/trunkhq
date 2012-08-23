class ChangeUserPrefixGroups < ActiveRecord::Migration
  def up
    change_table "user_prefix_groups", :force => true do |t|
      t.remove :max_minutes_per_day
      t.remove :rate
      t.integer :allowed_minites
      t.date :init_date
    end
  end

  def down
    change_table "user_prefix_groups", :force => true do |t|
      t.integer :max_minutes_per_day
      t.integer :rate
      t.remove :allowed_minites
      t.remove :init_date
    end
  end
end
