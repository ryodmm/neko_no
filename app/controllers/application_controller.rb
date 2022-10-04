class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  def reject_freeze_user
    if current_user && current_user.is_freeze?
      sign_out
      redirect_to new_user_session_path
    end
  end

  protected

    def after_sign_in_path_for(resource_or_scope)
      if resource_or_scope.is_a?(Admin)
          admin_users_path
      else
        posts_path
      end
    end

    def after_sign_out_path_for(resource_or_scope)
      if resource_or_scope == :user
          root_path
      elsif resource_or_scope == :admin
          new_admin_session_path
      else
          root_path
      end
    end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :user_id, :email, :password, :password_confirmation])
  end
end
