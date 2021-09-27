module DailyMenusHelper
  
  def make_order_or_see_history_button(menu)
    if menu.created_at.today? && current_user.orders.find_by(daily_menu: menu).nil?
      link_to 'Make an order', new_daily_menu_order_path(@daily_menus.first), 
                                class: "ui bottom attached blue button" 
    else 
      link_to 'History', menu, class: "ui bottom attached button" 
    end
  end
end
