class Event < ApplicationRecord
  belongs_to :argument
  belongs_to :user

  has_many :participations, dependent: :destroy
  has_many :participated_users, through: :participations, source: :user

  has_many :notifications, dependent: :destroy

  validates :title, presence: true

  def create_notification_comment!(current_user, event_comment_id)
    temp_ids = Participation.select(:user_id).where.not(user_id: current_user.id).distinct
    temp_ids.each do |temp_id|
      save_notification_comment!(current_user, event_comment_id, temp_id['user_id'])
    end
    save_notification_comment!(current_user, event_comment_id, user_id) if temp_ids.blank?
  end

  def save_notification_comment!(current_user, event_comment_id, visited_id)
    notification = current_user.active_notifications.new(
      event_id: id,
      event_comment_id: event_comment_id,
      visited_id: visited_id,
      action: 'comment'
    )
    if notification.visitor_id == notification.visited_id
      notification.looked = true
    end
    notification.save if notification.valid?
  end
end
