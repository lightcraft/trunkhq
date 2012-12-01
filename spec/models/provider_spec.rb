# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  login                  :string(15)
#  password               :string(15)
#  company                :string(100)      default("Private")
#  company_logo           :string(100)      default("/img/bird.gif")
#  application_name       :string(100)      default("Telefony")
#  last_login             :datetime
#  email                  :string(60)
#  role_id                :integer
#  encrypted_password     :string(255)      default("")
#  name                   :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0)
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  created_at             :datetime
#  updated_at             :datetime
#  confirmation_token     :string(255)
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string(255)
#  invitation_token       :string(60)
#  invitation_sent_at     :datetime
#  invitation_accepted_at :datetime
#  invitation_limit       :integer          default(3), not null
#  invited_by_id          :integer
#  invited_by_type        :string(255)
#  can_add_friendgroups   :boolean
#  provider_ip_address    :string(255)
#

require 'spec_helper'

describe Provider do
  pending "add some examples to (or delete) #{__FILE__}"
end
