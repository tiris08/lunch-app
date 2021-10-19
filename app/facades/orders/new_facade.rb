module Orders
  class NewFacade
    attr_reader :params, :order
    
    def initialize(order, params)
      @order = order
      @params = params
      3.times {order.order_items.build}
    end

    def daily_menu
      @daily_menu ||= DailyMenu.find(params[:daily_menu_id]).decorate
    end
  end
end
