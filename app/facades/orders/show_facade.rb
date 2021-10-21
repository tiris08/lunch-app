module Orders
  class ShowFacade
    attr_reader :order

    def initialize(order)
      @order = order.decorate
    end

    def user_order_cost
      @user_order_cost ||= order.food_items&.pluck(:price)&.sum
    end

    def user_order_items
      @user_order_items ||= order.food_items.decorate
    end
  end
end
