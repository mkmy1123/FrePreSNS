class EventComment < ApplicationRecord
  belongs_to :user
  belongs_to :event

  validates :body, presence: true, length: { minimum: 5, maximum: 100 }

end
