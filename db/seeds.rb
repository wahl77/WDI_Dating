# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


%w( Paul Mike John ).each do |name|
  User.create(:username => name, :password => name, :male => true)
end
%w( Johana Laura Michelle ).each do |name|
  User.create(:username => name, :password => name, :male => false)
end

100.times do 
  a = Message.new
  a.sender = User.all.sample(1).first
  a.receiver = User.all.sample(1).first
  a.content = "Lorem Ipsum"
  a.save
end

