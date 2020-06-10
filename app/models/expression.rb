class Expression < ApplicationRecord
  belongs_to :user
  belongs_to :argument

  has_many :reviews, dependent: :destroy
  has_many :notifications, dependent: :destroy

  validates :statement, presence: true, length: { minimum: 5, maximum: 20 }
  validates :position_of, presence: true

  enum position_of: {
    中立: 0,
    肯定的: 1,
    否定的: 2,
  }

  def create_notification_comment!(current_user, event_comment_id)
    temp_ids = Participation.select(:user_id).where.not(user_id: current_user.id).distinct
    temp_ids.each do |temp_id|
      save_notification_comment!(current_user, event_comment_id, temp_id['user_id'])
    end
    save_notification_comment!(current_user, event_comment_id, user_id) if temp_ids.blank?
  end
end
