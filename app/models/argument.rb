class Argument < ApplicationRecord
  acts_as_taggable_on :tags
  has_many :expressions
  has_many :events
  has_many :notifications, dependent: :destroy
  has_many :checks
  has_many :checked_users, through: :checks, source: :user

  validates :topic, presence: true, length: { in: 5..20 }
  validates :target, presence: true

  # TargetカラムのEnum
  enum target: {
    思想: 0,
    政治: 1,
    差別: 2,
    職業: 3,
    技術: 4,
    芸術: 5,
    学術: 6,
    娯楽: 7,
    嗜好: 8,
    その他: 20,
  }

  # CHECK済みARGUMENTに投稿があれば通知するメソッド
  def create_notification_checkedEexpression!(current_user, expression_id)
    # CHECKのユーザIDをこのargumentに限って変数化
    checked_ids = Check.select(:user_id).where(argument_id: id).distinct
    checked_ids.each do |check_id|
      notification = current_user.active_notifications.new(
        argument_id: id,
        expression_id: expression_id,
        visited_id: check_id['user_id'],
        action: 'checkedExpression'
      )
      # 通知元と通知先が同じならば既視扱いにする
      if notification.visitor_id == notification.visited_id
        notification.looked = true
      end
      notification.save if notification.valid?
    end
  end
end
