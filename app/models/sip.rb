# == Schema Information
#
# Table name: sip
#
#  id               :integer          not null, primary key
#  user_id          :integer          not null
#  name             :string(80)       not null
#  host             :string(31)       default("dynamic"), not null
#  nat              :string(5)        default("yes"), not null
#  type             :string(20)       default("friend"), not null
#  accountcode      :string(20)
#  amaflags         :string(13)
#  call-limit       :integer
#  callgroup        :string(10)
#  callerid         :string(80)
#  cancallforward   :string(3)        default("yes")
#  canreinvite      :string(3)        default("yes")
#  context          :string(80)
#  defaultip        :string(15)
#  dtmfmode         :string(7)
#  fromuser         :string(80)
#  fromdomain       :string(80)
#  insecure         :string(15)
#  language         :string(2)
#  mailbox          :string(50)
#  md5secret        :string(80)
#  deny             :string(95)
#  permit           :string(95)
#  mask             :string(95)
#  musiconhold      :string(100)
#  pickupgroup      :string(10)
#  qualify          :string(3)
#  regexten         :string(80)
#  restrictcid      :string(25)
#  rtptimeout       :string(3)
#  rtpholdtimeout   :string(3)
#  secret           :string(80)
#  setvar           :string(100)
#  disallow         :string(100)      default("all")
#  allow            :string(100)      default("ulaw;alaw;gsm;")
#  fullcontact      :string(80)       not null
#  ipaddr           :string(45)       not null
#  port             :integer          default(0), not null
#  regserver        :string(100)
#  regseconds       :integer          default(0), not null
#  lastms           :integer          default(0), not null
#  username         :string(80)       not null
#  defaultuser      :string(80)       not null
#  subscribecontext :string(80)
#  useragent        :string(33)
#  authuser         :string(25)
#  commented        :integer
#

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

  attr_accessible :name, :secret, :context, :host, :accountcode, :type, :user_id

  validates_numericality_of :name, :if => Proc.new { |sip| !sip.type.eql?('peer')}
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
