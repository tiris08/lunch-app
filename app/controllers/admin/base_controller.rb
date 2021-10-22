class Admin::BaseController < ApplicationController
  before_action :authenticate_user!
  before_action :verify_is_admin!

  def verify_is_admin!
    redirect_to root_path, alert: "You don't belong there" unless current_user&.is_admin?
  end
end
