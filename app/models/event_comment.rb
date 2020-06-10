class EventComment < ApplicationRecord
  belongs_to :user
  belongs_to :event

  has_many :notifications, dependent: :destroy

end
