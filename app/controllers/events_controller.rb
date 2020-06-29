class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update]
  before_action :reject_other_user, only: [:edit, :update]

  def index
    @events = Event.where(is_valid: true)
  end

  def create
    @event = Event.new(event_params)
    if @event.save
      redirect_to @event, notice: "Eventが作成できました！"
    else
      # 必要な情報をセットするメソッド
      set_data
      render "arguments/show"
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
    event_comments = EventComment.where(event_id: @event.id).includes(:user)
    @event_comments = arrangement(event_comments)
    # 参加予定のUSERをすべて取得
    @users = @event.participated_users
  end

  private

  def set_event
    @event = Event.find(params[:id])
  end

  def set_data
    @expression = Expression.new
    @argument = @event.argument
  end

  def event_params
    params.require(:event).permit(
      :title, :start_time, :end_time, :description,
      :all_day, :argument_id, :user_id, :is_valid
    )
  end

  def arrangement(event_comments)
    event_comments.page(params[:page]).per(15)
  end

  def reject_other_user
    unless @event.user == current_user
      redirect_back(fallback_location: root_path)
    end
  end
end
