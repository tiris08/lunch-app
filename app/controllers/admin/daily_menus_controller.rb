class Admin::DailyMenusController < Admin::BaseController
  before_action :find_daily_menu, only: [:show, :edit, :update]
  
  def index
    @index_facade = Admin::DailyMenus::IndexFacade.new(params)
  end

  def show
    @show_facade = Admin::DailyMenus::ShowFacade.new(@daily_menu)
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
  end

  def update
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

  def find_daily_menu
    @daily_menu = DailyMenu.find(params[:id])
  end
  
end 
