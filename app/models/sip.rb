class Channel < ActiveRecord::Base
  belongs_to :user
  has_one :channel

end