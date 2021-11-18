FactoryBot.define do
  factory :food_item do
    name { Faker::Food.dish }
    price { Faker::Commerce.price(range: 2..10) }
    course { %w[first_course main_course drink].sample }
    daily_menu
  end
end
