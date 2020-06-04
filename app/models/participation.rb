class Participation < ApplicationRecord
  belongs_to :user
  belongs_to :event

  validates_uniqueness_of :event_id, scope: :user_id
end
