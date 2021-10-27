class OrdersController < ApplicationController
  before_action :find_order, only: %i[update destroy edit show]
  before_action :check_policy
  before_action :check_if_todays_menu, except: %i[index show]

  def new
    @order = Order.new
    @facade = Orders::NewFacade.new(@order, params)
  end

  def index
    @facade = Orders::IndexFacade.new(current_user, params)
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

  def find_order
    @order = Order.find(params[:id])
  end

  def check_policy
    authorize(@order || Order)
  end

  def check_if_todays_menu
    return if DailyMenu.find(params[:daily_menu_id]).created_at.today?
    redirect_to root_path, alert: 'You are not allowed to perform this action'
  end
end
