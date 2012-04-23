# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

p1 = Package.create(:name => 'Package 1')
p2 = Package.create(:name => 'Package 1')
p3 = Package.create(:name => 'Package 1')

ps = [p1, p2, p3]

(1..100).each do |i|
  u = User.create(:name => "Zaharije #{i}", :package => ps[i % 3])
  (1..10).each do |ia|
    Album.create(:name => "Album #{i}-#{ia}", :user => u)
  end
end


