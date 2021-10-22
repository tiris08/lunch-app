class UserDecorator < ApplicationDecorator
  decorates_association :orders
  
  def joined_in_date
    h.l created_at
  end

  def last_order_date
    orders.present? ? h.l(orders.last.created_at) : "No orders yet"
  end
end
