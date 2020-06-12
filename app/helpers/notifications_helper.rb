module NotificationsHelper
  def notifications?
    current_user.passive_notifications.where(looked: false).present?
  end
end
