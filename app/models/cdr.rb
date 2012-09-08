class Cdr < ActiveRecord::Base
  self.table_name = 'cdr'
  default_scope order(:calldate)
  belongs_to :channel

  def self.channel_stats(channel)
    #TODO add conditions
    self.where('calldate > ?', Time.now - 1.month).where('calldate < ?', Time.current).where(['channel_id = ?', channel.id]).sum(:duration)
  end

end

#attributes:
#calldate: 2012-09-04 22:10:46.000000000 Z
#clid: ''
#src: gatewaeeeee
#dst: '0506426558'
#dcontext: default
#channel: SIP/yura-00000008
#dstchannel: SIP/213.231.10.5:7074-00000009
#lastapp: Dial
#lastdata: SIP/0506426558@213.231.10.5:7074
#duration: 13
#billsec: 0
#disposition: NO ANSWER
#amaflags: 3
#accountcode: ''
#userfield: ''
#hangupcause: ''
#peerip: ''
#recvip: ''
#fromuri: ''
#uri: ''
#useragent: ''
#codec1: ''
#codec2: ''
#llp: ''
#rlp: ''
#ljitt: ''
#rjitt: ''
#uniqueid: '1346785846.8'
#txjitter:
#rxjitter:
#rxploss:
#txploss:
#channel_id:
