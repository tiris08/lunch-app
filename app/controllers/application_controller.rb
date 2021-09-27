class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :configure_permitted_parameters_sign_up, if: :devise_controller?
  before_action :configure_permitted_parameters_account_update, if: :devise_controller?

  protected

  def configure_permitted_parameters_sign_up
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end

  def configure_permitted_parameters_account_update
    devise_parameter_sanitizer.permit(:account_update, keys: [:name])
  end
end
