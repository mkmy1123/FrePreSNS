class NotificationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @notifications = current_user.passive_notifications.includes(:visitor, :visited, :argument, :expression).where(looked: false).page(params[:page]).per(20)
    @partIn = current_user.participations.includes(:event).order(created_at: :desc).all
    @checks = current_user.checks.includes(:argument).order(created_at: :desc).all
  end

  def look
    @notifications = current_user.passive_notifications
    @notifications.where(looked: false).each do |notification|
      notification.update_attributes(looked: true)
    end
    redirect_to notifications_path
  end
end
