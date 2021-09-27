module DailyMenusHelper
  
  def make_order_or_see_history_button(menu)
    if menu.created_at.today? && current_user.orders.find_by(daily_menu: menu).nil?
      link_to 'Make an order', new_daily_menu_order_path(@daily_menus.first), 
                                class: "ui bottom attached blue button" 
    else 
      link_to 'History', menu, class: "ui bottom attached button" 
    end
  end


  def menu_course(item)
    item.course.gsub("_", " ").capitalize
  end
  
  def total_sold(menu)
    number_to_currency(menu.orders.includes(:food_items).pluck(:price).sum)
  end
  
  def most_popular_item(menu, course)
    OrderItem.includes(:food_item).where(food_item: {daily_menu: menu, course: course}).group(:food_item)
                                                                       .count
                                                                       .max_by { |k, v| v}
                                                                       &.first
                                                                       &.name
  end

end
