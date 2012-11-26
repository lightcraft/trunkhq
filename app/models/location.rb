class Location < ActiveRecord::Base
  attr_accessible :name, :order
  belongs_to :user
  has_many :channels, :dependent => :destroy

  validates :user, :name, :presence => true

  def self.asr_cdr(location_id)
    self.connection.execute("SELECT
  round((100 * sum(case when billsec > 0 then 1 else 0 end))/count(*)) as ASR,
  sum(billsec)/sum(case when billsec > 0 then 1 else 0 end) as ACD
  FROM cdr

  GROUP BY location_id").inspect

  end

end

#  WHERE location_id = #{location_id} AND datediff(curdate(),calldate) = 0