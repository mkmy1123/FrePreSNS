class EventCommentsController < ApplicationController
  def create
    @event_comment = EventComment.new(event_comment_params)
    @event_comment.event_id = params[:event_id]
    if @event_comment.save
      redirect_to @event_comment.event, notice: "投稿できました！返信を待ちましょう！"
    else
      redirect_to @event_comment.event, alert: "Errorが発生しました。もう一度投稿してください"
    end
  end

  private

  def event_comment_params
    params.require(:event_comment).permit(:body, :user_id, :event_id)
  end
end
