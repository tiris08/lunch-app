class RegistrationsController < Devise::RegistrationsController

  protected

  def sign_up_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def account_update_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :current_password)
  end

  def after_sign_up_path_for(resource)
    current_user.is_admin? ? admin_root_path : root_path
  end

  def after_update_path_for(resource)
    current_user.is_admin? ? admin_root_path : root_path
  end
end
