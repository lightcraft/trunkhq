# == Schema Information
#
# Table name: cdr
#
#  calldate        :datetime         not null
#  clid            :string(80)       default(""), not null
#  src             :string(80)       default(""), not null
#  dst             :string(80)       default(""), not null
#  dcontext        :string(80)       default(""), not null
#  channel         :string(80)       default(""), not null
#  dstchannel      :string(80)       default(""), not null
#  lastapp         :string(80)       default(""), not null
#  lastdata        :string(80)       default(""), not null
#  duration        :integer          default(0), not null
#  billsec         :integer          default(0), not null
#  disposition     :string(45)       default(""), not null
#  amaflags        :integer          default(0), not null
#  accountcode     :string(20)       default(""), not null
#  userfield       :string(255)      default(""), not null
#  hangupcause     :string(50)       not null
#  peerip          :string(50)       not null
#  recvip          :string(50)       not null
#  fromuri         :string(50)       not null
#  uri             :string(50)       not null
#  useragent       :string(50)       not null
#  codec1          :string(50)       not null
#  codec2          :string(50)       not null
#  llp             :string(50)       not null
#  rlp             :string(50)       not null
#  ljitt           :string(50)       not null
#  rjitt           :string(50)       not null
#  uniqueid        :string(32)       default(""), not null
#  txjitter        :decimal(10, 5)
#  rxjitter        :decimal(10, 5)
#  rxploss         :decimal(10, 5)
#  txploss         :decimal(10, 5)
#  channel_id      :integer
#  user_id         :integer
#  prefix_group_id :integer
#  location_id     :integer
#

class Cdr < ActiveRecord::Base
  self.table_name = 'cdr'
  default_scope order(:calldate)
  belongs_to :channel
  belongs_to :user
  belongs_to :prefix_group
 belongs_to :prefix

  scope :today, proc { where('calldate > ? AND calldate < ?', Date.today, Date.today + 1.days) }

  def self.lact_call_ident(channel)
    row = self.select('uniqueid').where(channel_id: channel.id).order('calldate desc ').first
    row.blank? ? '' : row.uniqueid
  end

  def self.channel_stats(channel)
    #TODO add conditions
    self.where('calldate > ?', Time.current - 1.month).where('calldate < ?', Time.current).where(['channel_id = ?', channel.id]).sum(:duration)
  end

  #  {:location_id=>10, :calls=>220, :asr=>#<BigDecimal:45bd3e0,'0.73E2',9(18)>, :acd=>#<BigDecimal:45bd340,'0.259E2',18(18)>}
  def self.asr_acd(location_id)
    row = self.connection.execute("SELECT location_id, count(*) as calls,
  round((100 * sum(case when billsec > 0 then 1 else 0 end))/count(*)) as ASR,
 sum(billsec)/sum(case when billsec > 0 then 1 else 0 end) as ACD
FROM cdr
WHERE location_id = #{location_id} AND datediff(curdate(),calldate) = 0
GROUP BY location_id").first
    return nil unless row
    {
        location_id: row[0],
        calls: row[1],
        asr: row[2].to_i,
        acd: row[3].to_i
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
