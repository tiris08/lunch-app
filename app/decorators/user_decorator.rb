class UserDecorator < ApplicationDecorator
  decorates_association :orders
  
  def joined_in_date
    created_at.strftime("%d %b %Y")
  end

  def last_order_date
    orders.present? ? orders.last.created_at.strftime("%d %b %Y") : "No orders yet"
  end
end
