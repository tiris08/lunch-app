FactoryBot.define do
  factory :order_item do
    order
    food_item
  end
end
