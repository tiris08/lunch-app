FactoryBot.define do
  factory :daily_menu do
    factory :menu_with_items do
      
      transient do
        items_count { 9 }
      end

      after(:create) do |daily_menu, evaluator|
        create_list(:food_item, evaluator.items_count, daily_menu: daily_menu)
        daily_menu.reload
      end
    end
  end
end
