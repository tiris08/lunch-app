class DailyMenuDecorator < ApplicationDecorator
  decorates_association :orders
  
  def formatted_created_at
    object.created_at.strftime("%d %b %Y")
  end

  def formatted_created_at_long
    object.created_at.strftime("%A %d %b %Y")
  end

  def created_at_day 
    object.created_at.strftime("%A")
  end
end
