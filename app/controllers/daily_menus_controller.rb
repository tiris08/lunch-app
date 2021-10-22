class DailyMenusController < ApplicationController
  before_action :verify_is_not_admin!
  skip_before_action :authenticate_user!, except: [:show]
  before_action :find_daily_menu, only: [:show]
  decorates_assigned :daily_menu
  
  def index
    @facade = DailyMenus::IndexFacade.new(params)
  end

  def show
  end

  private
  
  def verify_is_not_admin!
    if current_user&.is_admin?
      redirect_to admin_root_path, alert: "You don't belong there"
    end
  end

  def find_daily_menu
    @daily_menu = DailyMenu.find(params[:id])
  end
  
end
