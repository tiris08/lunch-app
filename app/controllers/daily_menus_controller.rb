class DailyMenusController < ApplicationController
  before_action :verify_is_not_admin!
  skip_before_action :authenticate_user!, :except => [:show]
  def index
    @daily_menus = DailyMenu.order(created_at: :desc).page(params[:page])
  end

  def show
    @daily_menu = DailyMenu.find(params[:id])
    @user_order = current_user.orders.find_by(daily_menu: @daily_menu)
    @user_order_cost = @user_order&.food_items&.pluck(:price)&.sum
  end

  private
  
  def verify_is_not_admin!
    if current_user&.is_admin?
      redirect_to admin_root_path, alert: "You don't belong there"
    end
  end
end
