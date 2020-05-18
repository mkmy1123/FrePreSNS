class Argument < ApplicationRecord
  has_many :expressions
  has_many :checks
  has_many :checked_users, through: :checks, source: :user
end
