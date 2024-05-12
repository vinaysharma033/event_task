class EventsController < ApplicationController
  def index
    @events = Event.all
  end

  def new
    @event = current_user.events.build
  end

  def create
    @event = current_user.events.build(event_params)

    if @event.save
      redirect_to @event, notice: 'Event was successfully created.'
    else
      render :new
    end
  end

  def show
    @event = Event.find(params[:id])
  end

  def edit
    @event = current_user.events.find(params[:id])
  end
  
  def update
    @event = current_user.events.find(params[:id])
    if @event.update(event_params)
      redirect_to @event, notice: 'Event was successfully updated.'
    else
      render :edit
    end
  end
  
  def destroy
    @event = current_user.events.find(params[:id])
    @event.destroy
    redirect_to events_url, notice: 'Event was successfully destroyed.'
  end
  
  def invite
    @event = current_user.events.find(params[:id])
    invited_user = User.find(params[:user_id])

    if @event.private?
      invitation = @event.invitations.build(invitee: invited_user)
      if invitation.save
        redirect_to @event, notice: 'Invitation sent successfully.'
      else
        redirect_to @event, alert: 'Failed to send invitation.'
      end
    else
      redirect_to @event, alert: 'This event is not private.'
    end
  end

  private
  
  def set_event
    @event = Event.find(params[:id])
  end

  def event_params
    params.require(:event).permit(:name, :date, :creator_id, :private)
  end

  def authorize_user
    unless current_user == @event.creator
      redirect_to @event, alert: "You are not authorized to perform this action."
    end
  end
end
