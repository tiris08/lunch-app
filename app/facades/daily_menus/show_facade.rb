module DailyMenus
  class ShowFacade
    attr_reader :daily_menu, :current_user
    
    def initialize(daily_menu, current_user)
      @daily_menu = daily_menu
      @current_user = current_user
    end

    def user_order
      @user_order ||= current_user&.orders&.find_by(daily_menu: daily_menu)
    end

    def user_order_cost
      @user_order_cost ||= user_order&.food_items&.pluck(:price)&.sum
    end

  end
end
