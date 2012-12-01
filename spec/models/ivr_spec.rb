# == Schema Information
#
# Table name: ivr
#
#  id         :integer          not null, primary key
#  number     :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  audio      :string(255)
#  file_name  :string(255)
#

require 'spec_helper'

describe Ivr do
  pending "add some examples to (or delete) #{__FILE__}"
end
