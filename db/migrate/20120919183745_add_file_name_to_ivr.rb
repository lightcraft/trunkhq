class AddFileNameToIvr < ActiveRecord::Migration
  def change
    add_column :ivr, :file_name, :string
  end
end
