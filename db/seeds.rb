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
  sleep(1)
  user = User.create! :name => Faker::Name.name, :email => Faker::Internet.email, :password => 'please', :password_confirmation => 'please', :confirmed_at => Time.now.utc
  puts 'New user created: ' << user.name
end