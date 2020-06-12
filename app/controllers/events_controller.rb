class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update]

  def index
    @events = Event.where(is_valid: true)
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
    if @event.update(event_params)
      redirect_to @event, notice: "Eventが変更されました！"
    else
      render :edit
    end
  end

  def show
    @event_comment = EventComment.new
    @event_comments = EventComment.where(event_id: @event.id).includes(:user).page(params[:page]).per(15)
    @users = @event.participated_users
  end

  def edit
  end

  private

  def set_event
    @event = Event.find(params[:id])
  end

  def event_params
    params.require(:event).permit(:title, :start_time, :end_time, :description, :all_day, :argument_id, :user_id, :is_valid)
  end
end
