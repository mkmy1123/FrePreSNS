class ParticipationsController < ApplicationController
  before_action :authenticate_user!

  def create
    @participation = current_user.participations.create(event_id: params[:event_id])
    respond_to do |format|
      format.js { flash.now[:notice] = "EVENTへの参加を 表明しました！ " }
    end
  end

  def destroy
    @participation = Participation.find_by(event_id: params[:event_id], user_id: current_user.id)
    @participation.destroy
    respond_to do |format|
      format.js { flash.now[:alert] = "EVENTへの参加表明を 取り消しました！" }
    end
  end
end
