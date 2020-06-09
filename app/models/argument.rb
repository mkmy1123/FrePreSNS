class Argument < ApplicationRecord
  acts_as_taggable_on :tags
  has_many :expressions
  has_many :events
  has_many :notifications, dependent: :destroy
  has_many :checks
  has_many :checked_users, through: :checks, source: :user

  # 通常のバリデーション
  validates :topic, presence: true, length: { minimum: 5, maximum: 20 }
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
end
