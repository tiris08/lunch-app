class DailyMenuDecorator < ApplicationDecorator

  def formatted_created_at
    object.created_at.strftime("%d %b %Y")
  end

  def formatted_created_at_long
    object.created_at.strftime("%A %d %b %Y")
  end

  def created_at_day 
    object.created_at.strftime("%A")
  end

  def edit_or_create_menu_link
    if object.created_at.today?
      h.link_to "Edit a menu for today ", h.edit_admin_daily_menu_path(object), class: "ui primary large button"
    else
      h.link_to "Create a menu for today", h.new_admin_daily_menu_path, class: "ui primary large button" 
    end
  end
end
