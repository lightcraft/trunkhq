class Sip < ActiveRecord::Base
  self.table_name = 'sip'

  belongs_to :user
  has_one :channel
  #column "type" - [user, peer, friend] - default friend

  #sip.context - 3 types

  # when add new chanel
  #sip.context = 'external' || null
  # Поставщик
  # sip.context = 'default'
  # Софтфон
  # sip.context  = 'internal'
  #
  #  Канал когда пользователь
  # sip.accountcode - channel.user_id
  # Поставщик   sip.accountcode   = user_id
  # Софтофон  -  sip.accountcode   = user_id

  # Создать свой софт фон (DIALER) для прозвонки своих модемов
  # insert sip(name,secret,type,accountcode,context) values ('login','pass','friend',user_id,'internal')


  #$diff = $row2['sip.regseconds'] - time();
  #$diff > 0  - ONLINE
  #$diff < 0  - OFFLINE

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