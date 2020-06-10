class EventCommentsController < ApplicationController
  def create
    @event_comment = EventComment.new(event_comment_params)
    @event_comment.event_id = params[:event_id]
    @event = @event_comment.event
    if @event_comment.save
      @event.create_notification_comment!(current_user, @event_comment.id)
      redirect_to @event, notice: "投稿できました！返信を待ちましょう！"
    else
      redirect_to @event, alert: "Errorが発生しました。もう一度投稿してください"
    end
  end

  private

  def event_comment_params
    params.require(:event_comment).permit(:body, :user_id, :event_id)
  end
end
