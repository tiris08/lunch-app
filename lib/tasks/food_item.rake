desc 'Update food item'
task update_food_item: :environment do
  FoodItem.last.update(name: 'taras')
end

