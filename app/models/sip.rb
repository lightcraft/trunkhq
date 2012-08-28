class Sip < ActiveRecord::Base
  self.table_name = 'sip'

  belongs_to :user
  has_one :channel
  #column "type" - [user, peer, friend] - default friend
  attr_accessible :name, :secret
  validates_numericality_of :name
  self.inheritance_column = "inheritance_type"

  before_validation(:on => :create) do
    self.callerid ||= self.name
    self.defaultuser ||= ''
    self.fullcontact ||= ''
    self.ipaddr ||= ''
    self.username ||= ''
  end

end