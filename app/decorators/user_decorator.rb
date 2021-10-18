class UserDecorator < ApplicationDecorator
  decorates_association :orders
  
  def joined_in_date
    object.created_at.strftime("%d %b %Y")
  end

  def last_order_date
    if object.orders.present?
      object.orders.last.created_at.strftime("%d %b %Y") 
    else
      "No orders yet"
    end
  end
end
