class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  protected

  def after_sign_in_path_for(_resource)
    current_user.is_admin? ? admin_root_path : root_path
  end

  def after_sign_out_path_for(_scope)
    new_user_session_path
  end
end
