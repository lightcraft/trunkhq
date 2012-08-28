# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
puts 'SETTING UP DEFAULT USER LOGIN'
user = User.create! :name => 'Admin User', :email => 'admin@example.com', :password => 'please', :password_confirmation => 'please', :confirmed_at => Time.now.utc
puts 'New user created: ' << user.name
user.add_role :admin

user2 = User.create! :name => 'Second User', :email => 'user@example.com', :password => 'please', :password_confirmation => 'please', :confirmed_at => Time.now.utc
puts 'New user created: ' << user2.name

11.times do
  user = User.create! :name => Faker::Name.name, :email => Faker::Internet.email, :password => 'please', :password_confirmation => 'please', :confirmed_at => Time.now.utc
  puts 'New user created: ' << user.name
end

puts "Crete prefix groups"
['MTS', 'UMC', 'Life'].each do |oper|
  PrefixGroup.create!(group_name: oper,  def_rate: 3, def_minutes_per_day: 1000, def_init_charge: 35)
end

puts "Create Prefixed for each group"
PrefixGroup.all.each do |group|
  Prefix.create!(prefix: rand(1000), prefix_group: group)
end

cnt = 1000
10.times do |time|
  cnt = cnt + 1
  ChanGroup.create!(chan_group_name: cnt, max_channels_cnt: cnt, max_channels_online: cnt)
end
