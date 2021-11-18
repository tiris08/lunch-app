FactoryBot.define do
  factory :order do
    association :user, factory: :random_user
    daily_menu
  end
end
