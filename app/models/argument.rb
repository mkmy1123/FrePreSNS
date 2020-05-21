class Argument < ApplicationRecord
  has_many :expressions
  has_many :checks
  has_many :checked_users, through: :checks, source: :user

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
    その他: 9,
  }
end
