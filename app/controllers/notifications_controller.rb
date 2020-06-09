class NotificationsController < ApplicationController
  def index
    @notifications = current_user.passive_notifications.page(params[:page]).per(20)
    @notifications.where(looked: false).each do |notification|
      notification.update_attributes(looked: true)
    end
  end
end
