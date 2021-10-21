class Admin::UsersController < Admin::BaseController
  before_action :find_user, only: [:show]
  decorates_assigned :user, :users
  
  def index
    @users = User.all
  end

  def show
    @facade = Admin::Users::ShowFacade.new(@user, params)
  end

  private

  def find_user
    @user = User.find(params[:id])
  end
end
