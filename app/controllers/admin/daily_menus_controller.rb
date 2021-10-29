class Admin::DailyMenusController < Admin::BaseController
  before_action :find_daily_menu, only: %i[show edit update]
  before_action :check_policy
  before_action :check_todays_menu_presence, only: %i[new create]
  before_action :check_if_todays_menu, only: %i[edit update]

  def index
    @facade = Admin::DailyMenus::IndexFacade.new(params)
  end

  def show
    @facade = Admin::DailyMenus::ShowFacade.new(@daily_menu)
  end

  def new
    @daily_menu = DailyMenu.new
    @daily_menu.food_items.build
    @q = FoodItem.ransack(name_cont: params[:q])
    @food_items = @q.result.select(:name).distinct.limit(6)
    respond_to do |f|
      f.html
      f.json { render json: @food_items, adapter: false }
    end
  end

  def create
    @daily_menu = DailyMenu.new(daily_menu_params)
    if @daily_menu.save
      redirect_to admin_daily_menu_path(@daily_menu), notice: 'Menu created!'
    else
      flash.now[:alert] = 'Try again. Your menu should include at least one valid item'
      render :new
    end
  end

  def edit
    @q = FoodItem.ransack(name_cont: params[:q])
    @food_items = @q.result.select(:name).distinct.limit(6)
    respond_to do |f|
      f.html
      f.json { render json: @food_items, adapter: false }
    end
  end

  def update
    if @daily_menu.update(daily_menu_params)
      redirect_to admin_daily_menu_path(@daily_menu), notice: 'Menu updated!'
    else
      flash.now[:alert] = 'Try again. Your menu should include at least one valid item'
      render :edit
    end
  end

  private

  def daily_menu_params
    params.require(:daily_menu).permit(food_items_attributes: %i[id name price course _destroy])
  end

  def find_daily_menu
    @daily_menu = DailyMenu.find(params[:id])
  end

  def check_policy
    authorize(@daily_menu || DailyMenu)
  end

  def check_todays_menu_presence
    return if DailyMenu.where(created_at: Time.zone.now.all_day).none?

    redirect_to admin_root_path, alert: 'You are not allowed to perform this action'
  end

  def check_if_todays_menu
    return if DailyMenu.find(params[:id]).created_at.today?

    redirect_to root_path, alert: 'You are not allowed to perform this action'
  end
end
