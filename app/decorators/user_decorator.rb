class UserDecorator < Draper::Decorator
  delegate_all

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
  
  # Define presentation-specific methods here. Helpers are accessed through
  # `helpers` (aka `h`). You can override attributes, for example:
  #
  #   def created_at
  #     helpers.content_tag :span, class: 'time' do
  #       object.created_at.strftime("%a %m/%d/%y")
  #     end
  #   end

end
