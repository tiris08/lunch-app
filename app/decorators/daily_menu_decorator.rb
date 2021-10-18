class DailyMenuDecorator < ApplicationDecorator
  decorates_association :orders
  
  def formatted_created_at
    created_at.strftime("%d %b %Y")
  end

  def formatted_created_at_long
    created_at.strftime("%A %d %b %Y")
  end

  def created_at_day 
    created_at.strftime("%A")
  end
  end
end
