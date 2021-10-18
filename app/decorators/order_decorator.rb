class OrderDecorator < Draper::Decorator
  delegate_all

  def food_items_in_one_sentence
    sentence = ""
    object.food_items.each { |e| object.food_items.last == e ? sentence += e.name + "." : sentence += e.name + ", " }
    sentence
  end

  def cost
    object.food_items.pluck(:price).sum
  end
end
