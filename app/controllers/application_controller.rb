class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  protected

  def after_sign_in_path_for(resource)
    current_user.is_admin? ? admin_root_path : root_path
  end

  def after_sign_out_path_for(scope)
    new_user_session_path
  end
end
