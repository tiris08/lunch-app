class DailyMenuDecorator < ApplicationDecorator
  decorates_association :orders
  decorates_association :food_items

  def formatted_created_at
    h.l created_at
  end

  def formatted_created_at_long
    h.l created_at, format: :full
  end

  def created_at_day
    h.l created_at, format: :day
  end

  def created_at_day_month
    h.l created_at, format: :day_month
  end

  def sorted_by_course_items
    food_items.order(:course)
  end

  def admin_edit_link
    return unless h.current_user.is_admin? && created_at.today?

    h.link_to 'Edit', h.edit_admin_daily_menu_path
  end
end
