class AddGsmNumberToChannel < ActiveRecord::Migration
  def up
    unless Channel.columns.map(&:name).include?('gsm_number')
      add_column :channels, :gsm_number, :string
    end
  end

  def down
    add_column :channels, :gsm_number
  end
end
