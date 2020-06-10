class Event < ApplicationRecord
  belongs_to :argument
  belongs_to :user

  has_many :participations, dependent: :destroy
  has_many :participated_users, through: :participations, source: :user

  validates :title, presence: true, length: { minimum: 5, maximum: 20 }
end
