class Expression < ApplicationRecord
  belongs_to :user
  belongs_to :argument
  has_many :reviews, dependent: :destroy

  validates :statement, presence: true, uniqueness: { scope: :user_id }

  enum position_of: {
    中立: 0,
    肯定的: 1,
    否定的: 2,
  }
end
