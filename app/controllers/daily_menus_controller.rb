class DailyMenusController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]
  before_action :find_daily_menu, only: [:show]
  decorates_assigned :daily_menu
  before_action :check_policy

  def index
    @facade = DailyMenus::IndexFacade.new(params, current_user)
  end

  def show; end

  private

  def find_daily_menu
    @daily_menu = DailyMenu.find(params[:id])
  end

  def check_policy
    authorize(@daily_menu || DailyMenu)
  end
end
