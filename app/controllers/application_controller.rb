class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  include Pundit

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  def user_not_authorized
    flash[:alert] = 'You are not authorized to perform this action.'
    if current_user.is_admin?
      redirect_to(request.referer || admin_root_path)
    else
      redirect_to(request.referer || root_path)
    end
  end

  def after_sign_in_path_for(_resource)
    current_user.is_admin? ? admin_root_path : root_path
  end

  def after_sign_out_path_for(_scope)
    new_user_session_path
  end
end
