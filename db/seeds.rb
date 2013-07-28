# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


User.destroy_all 

User.create(:username => "a", :password => "a", :male => true)

%w( Paul Mike John ).each do |name|
  User.create(:username => name, :password => name, :male => true)
end

%w( Johana Laura Michelle ).each do |name|
  User.create(:username => name, :password => name, :male => false)
end
#Make sure we have at least one of each
User.create(:username => "Lucy", :password => "Lucy", :male => false, :interested_in_male => false)
User.create(:username => "Charlotte", :password => "Charlotte", :male => false, :interested_in_male => true)
User.create(:username => "Max", :password => "Max", :male => true, :interested_in_male => false)
User.create(:username => "Harry", :password => "Harry", :male => true, :interested_in_male => true)

100.times do 
  a = Message.new
  a.sender = User.all.sample(1).first
  a.receiver = User.all.sample(1).first
  a.content = "Lorem Ipsum"
  a.save
end

