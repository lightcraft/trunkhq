class UserPrefixGroup < ActiveRecord::Base
  belongs_to :user
  belongs_to :prefix_group

end