class Expression < ApplicationRecord
  belongs_to :user
  has_many :reviews, dependent: :destroy

  validates :statement, presence: true, uniqueness: { scope: :user_id }
  enum argument_is: {
    0: 中立,
    1: 肯定,
    2: 反対
  }
end
