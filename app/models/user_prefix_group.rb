class UserPrefixGroup < ActiveRecord::Base
  # поставщики услуг
  belongs_to :user
  belongs_to :prefix_group

end