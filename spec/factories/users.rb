FactoryBot.define do
  factory :user do
    name { 'John Vedek' }
    email { 'pabsli@example.com' }
    password { 'password' }
    password_confirmation { 'password' }
    is_admin { false }
  end
  factory :random_user, class: User do
    name { Faker::Name.name }
    email { Faker::Internet.safe_email }
    password { 'password' }
    password_confirmation { 'password' }
    is_admin { false }
  end
end
