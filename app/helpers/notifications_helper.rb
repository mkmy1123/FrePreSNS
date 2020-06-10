module NotificationsHelper
  def unlooked_notifications
    @notifications = current_user.passive_notifications.where(looked: false)
  end
end
