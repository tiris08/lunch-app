class OrdersController < ApplicationController
  before_action :verify_is_not_admin!
  
  def new
    @order = Order.new
    @new_facade = Orders::NewFacade.new(@order, params)
  end

  def create
    @order = Order.new(order_params)
    if @order.save
      redirect_to daily_menu_path(@order.daily_menu), notice: "Your order was successfully created"
    else
      @course = ["First", "Main", "Drink"]
      flash.now[:alert] = "Try again. You have to select all three courses"
      render :new
    end 
  end

  def edit
    @order = Order.find(params[:id])
    @first_course = @order.order_items.find_or_initialize_by(food_item: @order.food_items
                                                              .find_by(course: "first_course"))
    @main_course = @order.order_items.find_or_initialize_by(food_item: @order.food_items
                                                              .find_by(course: "main_course"))
    @drink = @order.order_items.find_or_initialize_by(food_item: @order.food_items
                                                              .find_by(course: "drink"))
  end

  def update
    @order = Order.find(params[:id])
    if @order.update(order_params)
      redirect_to daily_menu_path(@order.daily_menu), notice: "Your order has been succesfully updated!"
    else
      @course = ["First", "Main", "Drink"]
      flash.now[:alert] = "Try again. You have to select all three courses"
      render :edit
    end
  end
  
  def destroy
    @order = Order.find(params[:id])
    @order.destroy
    redirect_to root_path, notice: "Your order has been succesfully deleted"
  end
  
  
  private

  def order_params
    params.require(:order).permit(:user_id, :daily_menu_id, order_items_attributes: [:id, :food_item_id, :order_id, :_destroy])
  end

  def verify_is_not_admin!
    if current_user&.is_admin?
      redirect_to admin_root_path, alert: "You don't belong there"
    end
  end
end
