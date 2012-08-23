class Sip < ActiveRecord::Base
  self.table_name = 'sip'

  belongs_to :user
  has_one :channel
  #column "type" - [user, peer, friend] - default friend

end