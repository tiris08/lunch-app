class FoodItemSerializer < ActiveModel::Serializer
  attributes :name, :course, :price

  def course
    object.course.humanize
  end
end
