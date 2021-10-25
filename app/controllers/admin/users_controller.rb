class Admin::UsersController < Admin::BaseController
  before_action :find_user, only: [:show]
  before_action :check_policy
  def index
    @facade = Admin::Users::IndexFacade.new(params)
  end

  def show
    @facade = Admin::Users::ShowFacade.new(@user, params)
  end

  private

  def find_user
    @user = User.find(params[:id])
  end

  def check_policy
    authorize(@user || User)
  end
end
