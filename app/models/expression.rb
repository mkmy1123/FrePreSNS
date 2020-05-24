class Expression < ApplicationRecord
  belongs_to :user
  has_many :reviews, dependent: :destroy

  validates :statement, presence: true, uniqueness: { scope: :user_id }
  enum style: {
    中立: 0,
    肯定的: 1,
    否定的: 2,
  }
end
