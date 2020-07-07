class NotificationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @notifications =
      current_user.passive_notifications.
      includes(:visitor, :visited, :event).where(looked: false).
      order(created_at: :desc).page(params[:page]).per(20)
    @events = current_user.participated_events.order(created_at: :desc)
    @arguments = current_user.checked_arguments.order(created_at: :desc)
  end

  def look
    notifications = current_user.passive_notifications
    notifications.where(looked: false).each do |notification|
      notification.update_attributes(looked: true)
    end
    redirect_to notifications_path
  end
end
