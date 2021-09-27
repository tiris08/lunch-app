class Admin::UsersController < Admin::BaseController
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    # @user_order_items = OrderItem.includes(food_item: :daily_menu).where(user: @user).group_by { |order_item| order_item.food_item.daily_menu }
    @user_total_spendings = @user.orders.includes(:food_items).pluck(:price).sum
    @user_total_orders = @user.orders.count
  end
end
