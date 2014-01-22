class Players::RegistrationsController < Devise::RegistrationsController
  before_filter :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :name << :twitter_id
    devise_parameter_sanitizer.for(:account_update) << :name << :twitter_id
  end

  def after_sign_in_path_for(resource)
    root_path
  end

  def after_update_path_for(resource)
    player_path(resource)
  end
end
