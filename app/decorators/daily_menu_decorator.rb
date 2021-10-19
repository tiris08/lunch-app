class DailyMenuDecorator < ApplicationDecorator
  decorates_association :orders
  decorates_association :food_items
  
  def formatted_created_at
    created_at.strftime("%d %b %Y")
  end

  def formatted_created_at_long
    created_at.strftime("%A %d %b %Y")
  end

  def created_at_day 
    created_at.strftime("%A")
  end

  def created_at_day_month
    created_at.strftime("%b %d")
  end

  def sorted_by_course_items
   food_items.order(:course)
  end
  
  def active_unactive_menu_link
    if h.current_user
      make_order_or_history_link(daily_menu)
    else
      h.content_tag(:button, "History", class: "ui bottom attached button", "data-tooltip"  => "You have to sign in first")
    end
  end

  def make_order_or_history_link(menu)
    if menu.created_at.today? && h.current_user.orders.find_by(daily_menu: menu).nil?
      h.link_to 'Make an order', h.new_daily_menu_order_path(menu), 
                                class: "ui bottom attached blue button" 
    else 
      h.link_to 'History', h.daily_menu_path(menu), class: "ui bottom attached button" 
    end
  end

  def admin_edit_link
    if h.current_user.is_admin? && created_at.today? 
      h.link_to "Edit", h.edit_admin_daily_menu_path
    end
  end
end
