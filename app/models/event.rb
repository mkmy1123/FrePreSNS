class Event < ApplicationRecord
  belongs_to :argument
  belongs_to :user

  has_many :participations, dependent: :destroy
  has_many :participated_users, through: :participations, source: :user

  validates :title, presence: true, length: { in: 5..20 }
  validates :start_time, presence: true
  validates :end_time, presence: true
  validates :description, presence: true, length: { maximum: 255 }
  validate :start_time_cannot_be_in_the_past, :end_time_cannot_be_in_the_past
  validate :end_time_cannot_be_in_the_past_than_start_time
  has_many :notifications, dependent: :destroy

  # イベントコメント通知作成メソッドの大枠
  def create_notification_comment!(current_user, event_comment_id)
    # 参加表明の中から自分以外のユーザIDを変数化
    part_ids = Participation.select(:user_id).where.not(user_id: current_user.id).distinct
    part_ids.each do |part_id|
      save_notification_comment!(current_user, event_comment_id, part_id['user_id'])
    end
    # 参加者0の場合、イベント作成者に通知
    save_notification_comment!(current_user, event_comment_id, user_id) if temp_ids.blank?
  end

  # イベントコメント通知作成メソッド
  def save_notification_comment!(current_user, event_comment_id, visited_id)
    notification = current_user.active_notifications.new(
      event_id: id,
      event_comment_id: event_comment_id,
      visited_id: visited_id,
      action: 'comment'
    )
    # 通知元と通知先が同じならば既視扱いにする
    if notification.visitor_id == notification.visited_id
      notification.looked = true
    end
    notification.save if notification.valid?
  end

  def start_time_cannot_be_in_the_past
    if start_time.present? && start_time < Date.today
      errors.add(:start_time, "に過去の日付は使えません")
    end
  end

  def end_time_cannot_be_in_the_past
    if end_time.present? && end_time < Date.today
      errors.add(:end_time, "に過去の日付は使えません")
    end
  end

  def end_time_cannot_be_in_the_past_than_start_time
    if end_time.present? && end_time < start_time
      errors.add(:end_time, "は開始時間より過去の日付は使えません")
    end
  end
end
