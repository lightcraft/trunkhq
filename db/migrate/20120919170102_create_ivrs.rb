class CreateIvrs < ActiveRecord::Migration
  def change
    create_table :ivr do |t|
      t.string :number

      t.timestamps
    end
  end
end
