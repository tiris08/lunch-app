module Admin
  module Users
    class ShowFacade
      include ActionView::Helpers::NumberHelper
      attr_reader :user, :params
      
      def initialize(user, params)
        @user = user
        @params = params
      end

      def decorated_user
        @decorated_user ||= user.decorate
      end

      def user_total_spending
        @user_total_spending ||= number_to_currency(user.orders.includes(:food_items).pluck(:price).sum)
      end

      def user_total_orders
        @user_total_orders ||= user.orders.count
      end

      def paginated_user_orders
        @paginated_user_orders ||= user.orders.page(params[:page]).per(12).decorate
      end
    end
  end
end
