# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)



%w[admin guest customer service].each do |role|
  Role.find_or_create_by({ name: role }) unless Role.find_by(name: role)
end

# 10.times do |n|
  # test@gmail.com, ps: tester
  # User.find_or_create_by(email:"user#{n}@hotmail.com", password:"testing", role_id:(Role.count-1)+1) unless User.find_by(email:"user#{n}@hotmail.com")
# end

['Standard Delivery (7 Days)', 'Express Delivery (2 Days)', 'Self-Collect'].each do |mode|
  DeliveryMode.find_or_create_by({ name: mode })
end

5.times do |n|
  Category.find_or_create_by(name:"Category #{n + 1}") unless Category.find_by(name: "Category #{n+1}")
end

20.times do |n|
  brand_name = Faker::Appliance.brand
  Brand.find_or_create_by(name:brand_name) unless Brand.find_by(name: brand_name)
end

100.times do |n|
  item_name = Faker::Appliance.equipment
  Item.create(name:item_name, price:rand(500)+1,category_id:rand(Category.count-1)+1,brand_id:rand(Brand.count-1)+1,description:BetterLorem.w(50,true),quantity:rand(200)+1)
end

Promotion.feed_csv

User.create(email:'test@gmail.com',password:'tester',role_id:1)
