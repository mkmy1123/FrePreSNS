class RoomsController < ApplicationController
  before_action :authenticate_user!

  def create
    @room = Room.create
    # その部屋に入るユーザーを紐付けるための中間テーブル / お互いに必要
    @entry1 = Entry.create(room_id: @room.id, user_id: current_user.id)
    @entry2 = Entry.create(params.require(:entry).permit(:user_id, :room_id).merge(room_id: @room.id))
    redirect_to "/rooms/#{@room.id}"
  end

  def show
    @room = Room.find(params[:id])
    # すでに会話が行われているか確認
    if Entry.where(user_id: current_user.id, room_id: @room.id).present?
      @messages = @room.messages.includes(:user).order(created_at: :desc).page(params[:page])
      @message = Message.new
      @entries = @room.entries
    else
      redirect_back(fallback_location: root_path)
    end
  end
end
