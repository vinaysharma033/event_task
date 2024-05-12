class AttendancesController < ApplicationController

  before_action :authenticate_user!

  def remove_attendee
    @event = Event.find(params[:id])
    if @event.attendees.exists?(current_user.id)
      @event.attendees.delete(current_user)
      redirect_to @event, notice: 'You have been removed from the attendee list.'
    else
      redirect_to @event, alert: 'You are not attending this event.'
    end
  end
  
  def create
    @event = Event.find(params[:event_id])
    current_user.attendances.create(event: @event)
    redirect_to @event, notice: "You are now attending this event."
  end

  def destroy
    @attendance = current_user.attendances.find(params[:id])
    @event = @attendance.event
    @attendance.destroy
    redirect_to @event, notice: "You are no longer attending this event."
  end
end
