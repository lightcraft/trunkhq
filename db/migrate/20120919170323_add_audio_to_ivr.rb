class AddAudioToIvr < ActiveRecord::Migration
  def change
    add_column :ivr, :audio, :string
  end
end
