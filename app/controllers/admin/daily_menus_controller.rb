class Admin::DailyMenusController < Admin::BaseController
  before_action :find_daily_menu, only: %i[show edit update]

  def index
    @facade = Admin::DailyMenus::IndexFacade.new(params)
  end

  def show
    @facade = Admin::DailyMenus::ShowFacade.new(@daily_menu)
  end

  def new
    @daily_menu = DailyMenu.new
    @daily_menu.food_items.build
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

  def edit; end

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
end
