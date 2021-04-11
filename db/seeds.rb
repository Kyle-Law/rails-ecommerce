# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)



Category.create(name:'Category 1')
Category.create(name:'Category 2')
Category.create(name:'Category 3')

%w[admin guest customer service].each do |role|
  Role.find_or_create_by({ name: role })
end

10.times do |n|
  User.create(email:"user#{n}@hotmail.com",password:"testing",role_id:(Role.count-1)+1)
end

['Standard Delivery (7 Days)', 'Express Delivery (2 Days)', 'Self-Collect'].each do |mode|
  DeliveryMode.find_or_create_by({ name: mode })
end

20.times do |n|
  brand_name = Faker::Appliance.brand
  Brand.create(name:brand_name) unless Brand.find_by(name: brand_name)
end

100.times do |n|
  item_name = Faker::Appliance.equipment
  Item.create(name:item_name, price:rand(500)+1,category_id:rand(Category.count-1)+1,brand_id:rand(Brand.count-1)+1,description:BetterLorem.w(50,true))
end
