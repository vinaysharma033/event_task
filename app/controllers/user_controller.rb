class UserController < ApplicationController
  before_action :authenticate_user!
  
  def show
    @user = current_user
    if @user
      @events = @user.events
      @attended_events = @user.attended_events
    else
      flash[:alert] = "User not found"
      redirect_to root_path
    end
  end
end
