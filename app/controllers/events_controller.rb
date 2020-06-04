class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]

  def index
    @events = Event.all
  end

  def create
    @event = Event.new(event_params)
    if @event.save
      redirect_to @event, notice: "Eventが作成できました！"
    else
      render :index
    end
  end

  def update
    @event.update(event_params)
  end

  def show
  end

  def edit
  end

  def destroy
    @event.destroy
  end

  private
  def set_event
    @event = Event.find(params[:id])
  end

  def event_params
    params.require(:event).permit(:title, :start_time, :end_time, :description, :all_day, :argument_id, :user_id)
  end
end
