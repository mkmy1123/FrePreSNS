class EventComment < ApplicationRecord
  belongs_to :user
  belongs_to :event

  has_many :notifications, dependent: :destroy

  validates :body, presence: true, length: { in: 1..100 }
end
