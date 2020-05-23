class Expression < ApplicationRecord
  belongs_to :user
  has_many :reviews, dependent: :destroy

  validates :statement, presence: true, uniqueness: { scope: :user_id }

end
