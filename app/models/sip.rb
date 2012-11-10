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
  #  Канал когда пользователь добавил на колбек перед созданием//
  # sip.accountcode - channel.user_id
  # Поставщик   sip.accountcode   = user_id
  # Софтофон  -  sip.accountcode   = user_id

  # Создать свой софт фон (DIALER) для прозвонки своих модемов
  # insert sip(name,secret,type,accountcode,context) values ('login','pass','friend',user_id,'internal')

  attr_accessible :name, :secret, :context
  validates_numericality_of :name
  #validate :secret, :present => true, :if => { |sip| sip.context.eql?('internal')}
  self.inheritance_column = "inheritance_type"

  before_validation(:on => :create) do
    self.context = 'external' if self.context.blank? # по умолчанию елси не установлен считаем что это внешний сип канал
    self.accountcode = self.user_id
    self.callerid ||= self.name
    self.defaultuser ||= ''
    self.fullcontact ||= ''
    self.ipaddr ||= ''
    self.username ||= ''
  end
  #
  ##Создаем софт фон для пользователя
  #def self.create_soft_phone(args = {})
  #  soft_phone = self.new(name: args[:login], secret: args[:pass], user: args[:user], context: 'internal')
  #  soft_phone.save
  #end
end