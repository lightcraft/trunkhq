class ActiveCall < ActiveRecord::Migration
  def up
    create_table(:active_calls, force: true) do |t|
      t.string :uniqueid, limit: 32
      t.integer :channel_id
      t.references :user
      t.integer :sip_id
      t.integer :provider_account_id
      t.datetime :start_time
      t.string :src, limit: 25
      t.string :dst, limit: 25
      t.integer :max_duration
      t.integer :prefix_group_id

      t.timestamps
    end

    add_index :active_calls, :sip_id
    add_index :active_calls, :channel_id
    add_index :active_calls, :provider_account_id
    add_index :active_calls, :prefix_group_id
  end

  def down
    remove_table :active_calls
    remove_index :active_calls, :sip_id
    remove_index :active_calls, :channel_id
    remove_index :active_calls, :provider_account_id
    remove_index :active_calls, :prefix_group_id
  end

end
