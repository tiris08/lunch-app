module OrdersHelper
  
  def group_food_itmes_by_course(order)
    order.daily_menu.food_items.group_by { |e| e.course.humanize }
  end

  def courses
    ["First", "Main", "Drink"]
  end
end
