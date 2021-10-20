class OrderDecorator < ApplicationDecorator
  decorates_association :daily_menu
  delegate :name, to: :user, prefix: true

  def food_items_humanized
    food_items.map(&:name).to_sentence(last_word_connector: ', ')
  end

  def formatted_created_at
    h.l created_at
  end

  def cost
    h.number_to_currency(food_items.pluck(:price).sum)
  end
end
