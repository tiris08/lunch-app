class OrderDecorator < ApplicationDecorator
  decorates_association :daily_menu
  
  
  def food_items_in_one_sentence
    food_items.map{ |e| e.name }.to_sentence(last_word_connector: ', ')
  end

  def cost
    h.number_to_currency(food_items.pluck(:price).sum)
  end
end
