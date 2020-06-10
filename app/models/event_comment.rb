class EventComment < ApplicationRecord
  belongs_to :user
  belongs_to :event

  has_many :notifications, dependent: :destroy

  validates :body, presence: true, length: { minimum: 5, maximum: 100 }

end
