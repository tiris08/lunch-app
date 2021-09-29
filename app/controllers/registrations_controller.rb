class RegistrationsController < Devise::RegistrationsController

  protected

  def after_sign_up_path_for(resource)
    current_user.is_admin? ? admin_root_path : root_path
  end

  def after_update_path_for(resource)
    current_user.is_admin? ? admin_root_path : root_path
  end
end
