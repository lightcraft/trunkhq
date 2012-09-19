class Ivr < ActiveRecord::Base
  self.table_name = 'ivr'
  attr_accessible :number, :audio, :remote_audio_url

  mount_uploader :audio, AudioUploader
  before_save :store_full_path

  def store_full_path
    self.file_name = self.audio ? self.audio.current_path : ''
  end

end
