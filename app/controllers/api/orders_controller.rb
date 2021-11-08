class Api::OrdersController < Api::BaseController
  def index
    @orders = Order.where(created_at: Time.zone.now.all_day)

    render json: @orders
  end
end
