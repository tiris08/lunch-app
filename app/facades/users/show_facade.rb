module Users
  class ShowFacade
    include ActionView::Helpers::NumberHelper
    attr_reader :user
    
    def initialize(user)
      @user = user
    end

    def user_total_spending
      @user_total_spending ||= number_to_currency(user.orders.includes(:food_items).pluck(:price).sum)
    end

    def user_total_orders
      @user_total_orders ||= user.orders.count
    end
  end
end
