class Participation < ApplicationRecord
  belongs_to :user
  belongs_to :event

  validates_uniqueness_of :event_id, scope: :user_id
  validates :user_id, presence: true
  validates :event_id, presence: true
end
