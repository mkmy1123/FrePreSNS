class Review < ApplicationRecord
  belongs_to :user
  belongs_to :expression

  validates :rate, numericality: {
    less_than_or_equal_to: 5,
  } , presence: true
  validates_uniqueness_of :expression_id, scope: :user_id
end
