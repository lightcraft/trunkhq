class DropTableUserRate < ActiveRecord::Migration
  def up
    drop_table :user_rates
  end

  def down
    create_table :user_rates
  end
end
