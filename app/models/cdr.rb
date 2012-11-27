class Cdr < ActiveRecord::Base
  self.table_name = 'cdr'
  default_scope order(:calldate)
  belongs_to :channel
  belongs_to :user
  belongs_to :prefix_group

  scope :today, proc { where('calldate > ? AND calldate < ?', Date.today, Date.today + 1.days ) }

  def self.channel_stats(channel)
    #TODO add conditions
    self.where('calldate > ?', Time.now - 1.month).where('calldate < ?', Time.current).where(['channel_id = ?', channel.id]).sum(:duration)
  end

  #  {:location_id=>10, :calls=>220, :asr=>#<BigDecimal:45bd3e0,'0.73E2',9(18)>, :acd=>#<BigDecimal:45bd340,'0.259E2',18(18)>}
  def self.asr_acd(location_id)
    row = self.connection.execute("SELECT location_id, count(*) as calls,
  round((100 * sum(case when billsec > 0 then 1 else 0 end))/count(*)) as ASR,
 sum(billsec)/sum(case when billsec > 0 then 1 else 0 end) as ACD
from cdr
   where location_id = #{location_id} GROUP BY location_id").first
    return nil unless row
    {
        location_id: row[0],
        calls: row[1],
        asr: row[2],
        acd: row[3]
    }
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
