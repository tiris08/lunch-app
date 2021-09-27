class Admin::DailyMenusController < Admin::BaseController
  def index
    @daily_menus = DailyMenu.order(created_at: :desc).page(params[:page])
  end

  def show
    @daily_menu = DailyMenu.find(params[:id])
  end

  def new
    @daily_menu = DailyMenu.new
    @daily_menu.food_items.build
  end

  def create
    @daily_menu = DailyMenu.new(daily_menu_params)
    if @daily_menu.save
      redirect_to admin_daily_menu_path(@daily_menu), notice: "Menu created!"
    else
      render :new
    end
  end

  def edit
    @daily_menu = DailyMenu.find(params[:id])
  end

  def update
    @daily_menu = DailyMenu.find(params[:id])
    if @daily_menu.update(daily_menu_params)
      redirect_to admin_daily_menu_path(@daily_menu), notice: "Menu updated!"
    else
      render :edit
    end
  end

  private

  def daily_menu_params
    params.require(:daily_menu).permit(food_items_attributes:[:id, :name, :price, :course, :_destroy])
  end
  
end 
