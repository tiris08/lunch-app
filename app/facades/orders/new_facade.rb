module Orders
  class NewFacade
    attr_reader :params, :order

    def initialize(order, params)
      @order = order
      @params = params
      3.times { order.order_items.build }
    end

    def daily_menu
      @daily_menu ||= DailyMenu.find(daily_menu_id).decorate
    end

    def food_items_collection(course)
      FoodItem.where(daily_menu_id: daily_menu_id, course: course)
    end

    private

    def daily_menu_id
      @daily_menu_id ||= params[:daily_menu_id]
    end
  end
end
