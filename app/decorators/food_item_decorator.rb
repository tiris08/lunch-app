class FoodItemDecorator < ApplicationDecorator
  def humanized_course
    course.humanize
  end

  def price_in_currency
    h.number_to_currency(price)
  end

  def info_mail
    "#{name} (#{humanized_course}) - #{price_in_currency}"
  end
end
