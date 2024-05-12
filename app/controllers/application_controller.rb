class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:date, :name])
  end

  def authorize_creator!
    unless @event.editable_by?(current_user)
      redirect_to root_path, alert: "You are not authorized to perform this action."
    end
  end

  def authorize_invited_user!
    unless @event.invited?(current_user)
      redirect_to root_path, alert: "You are not invited to this event."
    end
  end
end
