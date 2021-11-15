# This file should contain all the record creation needed to 
# seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command 
# (or created alongside the database with db:setup).

# Examples:

#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'

drinks = ["Coke", "Juice", "Tea", "Coffe", "Water"]

14.times do |day|
  time = 14.days.ago + day.day
  if time.on_weekday? && !(time > Time.now)
    food_items_attributes = [{ name: Faker::Food.dish,
                               price: Faker::Commerce.price(range: 5..10),
                               course: 0},
                             { name: Faker::Food.dish,
                               price: Faker::Commerce.price(range: 5..10),
                               course: 0},
                             { name: Faker::Food.dish,
                               price: Faker::Commerce.price(range: 5..10),
                               course: 0},
                             { name: Faker::Food.dish,
                               price: Faker::Commerce.price(range: 5..10),
                               course: 1},
                             { name: Faker::Food.dish,
                               price: Faker::Commerce.price(range: 5..10),
                               course: 1},
                             { name: Faker::Food.dish,
                               price: Faker::Commerce.price(range: 5..10),
                               course: 1},
                             { name: drinks.sample,
                               price: Faker::Commerce.price(range: 5..10),
                               course: 2},
                             { name: drinks.sample,
                               price: Faker::Commerce.price(range: 5..10),
                               course: 2},
                             { name: drinks.sample,
                               price: Faker::Commerce.price(range: 5..10),
                               course: 2}]
    menu = DailyMenu.create(created_at: time,
                            food_items_attributes: food_items_attributes)
  end
end

20.times do |i|
  name = Faker::Name.name
  email = "example-#{i}@gmail.com"
  User.create(name: name, email: email, password: "password", password_confirmation: "password")
end

15.times do |number|
  number += 2
  user = User.find(number)
  10.times do |n|
    menu = DailyMenu.find(DailyMenu.last.id - n)
    order = Order.new(user_id: user.id, daily_menu_id: menu.id)
    3.times do |num|
      food_item = menu.food_items.where(course: num).first
      order_item = order.order_items.build
      order_item.food_item_id = food_item.id
      order_item.save
    end
    order.save
  end
end
