class OrdersController < ApplicationController
  before_action :verify_is_not_admin!
  before_action :find_order, only: %i[update destroy edit show]

  def new
    @order = Order.new
    @facade = Orders::NewFacade.new(@order, params)
  end

  def index
    @user_orders = Order.where(user: current_user).order(created_at: :desc).decorate
  end

  def show
    @facade = Orders::ShowFacade.new(@order)
  end

  def create
    @order = Order.new(order_params)
    if @order.save
      redirect_to order_path(@order), notice: 'Your order was successfully created'
    else
      @facade = Orders::NewFacade.new(@order, params)
      flash.now[:alert] = 'Try again. You have to select all three courses'
      render :new
    end
  end

  def edit
    @facade = Orders::EditFacade.new(@order, params)
  end

  def update
    if @order.update(order_params)
      redirect_to order_path(@order), notice: 'Your order has been succesfully updated!'
    else
      @facade = Orders::EditFacade.new(@order, params)
      flash.now[:alert] = 'Try again. You have to select all three courses'
      render :edit
    end
  end

  def destroy
    @order.destroy
    redirect_to root_path, notice: 'Your order has been succesfully deleted'
  end

  private

  def order_params
    params.require(:order).permit(:user_id, :daily_menu_id,
                                  order_items_attributes: %i[id food_item_id order_id _destroy])
  end

  def verify_is_not_admin!
    redirect_to admin_root_path, alert: "You don't belong there" if current_user&.is_admin?
  end

  def find_order
    @order = Order.find(params[:id])
  end
end
