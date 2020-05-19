class Argument < ApplicationRecord
  has_many :expressions
  has_many :checks
  has_many :checked_users, through: :checks, source: :user

  enum target:{
    思想: 0,
    政治: 1,
    差別: 2,
    職業: 3,
    技術: 4,
    政治: 5,
    芸術: 6,
    学術: 7,
    娯楽: 8,
    嗜好: 9
  }
end
