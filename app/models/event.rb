class Event < ApplicationRecord
  belongs_to :argument
  belongs_to :user

  has_many :participations, dependent: :destroy
  has_many :participated_users, through: :participations, source: :user
end
