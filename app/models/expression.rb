class Expression < ApplicationRecord
  belongs_to :user
  belongs_to :argument

  has_many :reviews, dependent: :destroy
  has_many :notifications, dependent: :destroy

  validates_uniqueness_of :argument_id, scope: :user_id
  validates :statement, presence: true, length: { minimum: 5, maximum: 20 }
  validates :position_of, presence: true

  enum position_of: {
    中立: 0,
    肯定的: 1,
    否定的: 2,
  }
end
