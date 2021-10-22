# This file should contain all the record creation needed to 
# seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command 
# (or created alongside the database with db:setup).

# Examples:

#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# require 'faker'

# drinks = ["Coke", "Juice", "Tea", "Coffe", "Water"]

# 99.times do |day|
#   time = 2.month.ago + day.day
#   if time.on_weekday? && !(time > Time.now)
#     menu = DailyMenu.create(created_at: time,
#                               food_items_attributes: { 
                                                                # "0": { name: Faker::Food.dish,
#                                                               price: Faker::Commerce.price(range: 5..10),
#                                                               course: 0},
#                                                         "1": { name: Faker::Food.dish,
#                                                               price: Faker::Commerce.price(range: 5..10),
#                                                               course: 0},
#                                                         "2": { name: Faker::Food.dish,
#                                                               price: Faker::Commerce.price(range: 5..10),
#                                                               course: 0},
#                                                         "3": { name: Faker::Food.dish,
#                                                               price: Faker::Commerce.price(range: 5..10),
#                                                               course: 1},
#                                                         "4": { name: Faker::Food.dish,
#                                                               price: Faker::Commerce.price(range: 5..10),
#                                                               course: 1},
#                                                         "5": { name: Faker::Food.dish,
#                                                               price: Faker::Commerce.price(range: 5..10),
#                                                               course: 1},
#                                                         "6": { name: drinks.sample,
#                                                               price: Faker::Commerce.price(range: 5..10),
#                                                               course: 2},
#                                                         "7": { name: drinks.sample,
#                                                               price: Faker::Commerce.price(range: 5..10),
#                                                               course: 2},
#                                                         "8": { name: drinks.sample,
#                                                               price: Faker::Commerce.price(range: 5..10),
#                                                               course: 2}})
#     3.times do
#       name = Faker::Food.dish
#       price = Faker::Commerce.price(range: 5..10)
#       menu.food_items.create(name: name, price: price, course: 0)
#       name = Faker::Food.dish
#       price = Faker::Commerce.price(range: 7..10)
#       menu.food_items.create(name: name, price: price, course: 1)
#       name = drinks.sample
#       price = Faker::Commerce.price(range: 2..5)
#       menu.food_items.create(name: name, price: price, course: 2)
#     end
#   end
# end

# 20.times do |i|
#   name = Faker::Name.name
#   email = "example-#{i}@gmail.com"
#   User.create(name: name, email: email, password: "password", password_confirmation: "password")
# end

# 18.times do |number|
#   user = User.find(number + 2)
#   20.times do |n|
#     menu = DailyMenu.find(44 - n)
#     order = Order.new(user_id: user.id, daily_menu_id: menu.id)
#     3.times do |num|
#       food_item = menu.food_items[num]
#       order.order_items.build
#       order.order_items[num].food_item_id = food_item.id
#       order.save
#     end
#   end
# end
