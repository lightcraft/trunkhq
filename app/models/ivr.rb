# == Schema Information
#
# Table name: ivr
#
#  id         :integer          not null, primary key
#  number     :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  audio      :string(255)
#  file_name  :string(255)
#

class Ivr < ActiveRecord::Base
  self.table_name = 'ivr'
  attr_accessible :number, :audio, :remote_audio_url

  mount_uploader :audio, AudioUploader
  before_save :store_full_path

  def store_full_path
    self.file_name = self.audio ? self.audio.current_path : ''
  end

end
