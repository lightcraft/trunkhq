class Location < ActiveRecord::Base
  attr_accessible :name, :order
  belongs_to :user
  has_many :channels, :dependent => :destroy

  validates :user, :name, :presence => true

  def asr_cdr

  "SELECT
  round((100 * sum(case when billsec > 0 then 1 else 0 end))/count(*)) as ASR,
                                                                          sum(billsec)/sum(case when billsec > 0 then 1 else 0 end) as ACD
  FROM cdr
  WHERE datediff(curdate(),calldate) = 0 and location_id =
  GROUP BY location_id "
  end

end
