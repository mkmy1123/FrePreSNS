class Relationship < ApplicationRecord
  belongs_to :user
  belongs_to :trust, class_name: 'User'

  validates :user_id, presence: true
  validates :trust_id, presence: true
end
