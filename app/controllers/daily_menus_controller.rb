class DailyMenusController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]
  before_action :find_daily_menu, only: [:show]
  decorates_assigned :daily_menu

  def index
    @facade = DailyMenus::IndexFacade.new(params)
  end

  def show; end

  private

  def find_daily_menu
    @daily_menu = authorize DailyMenu.find(params[:id])
  end
end
