class Gateway < Sip

  attr_accessible :accountcode

  before_validation(:on => :create) do
    logger.debug("CALIDARE GATEW")
    self.context = 'default'
    self.type = 'peer'

    self.user_id = self.accountcode
    self.callerid ||= self.name
    self.defaultuser ||= ''
    self.fullcontact ||= ''
    self.ipaddr ||= ''
    self.username ||= ''
    logger.debug(self.inspect)
  end

end
