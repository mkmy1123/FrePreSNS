class Expression < ApplicationRecord
  belongs_to :user
  belongs_to :argument
  has_many :reviews, dependent: :destroy

  validates :statement, presence: true, uniqueness: { scope: :user_id, message: "同じ要点の内容で、すでに投稿されています..." }
  validates :position_of, presence: true

  enum position_of: {
    中立: 0,
    肯定的: 1,
    否定的: 2,
  }
end
