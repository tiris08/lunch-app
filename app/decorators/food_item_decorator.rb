class FoodItemDecorator < ApplicationDecorator
  def humanized_course
    course.humanize
  end
end