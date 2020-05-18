class Check < ApplicationRecord
  belongs_to :user
  belongs_to :argument
  validates_uniqueness_of :argumet_id, scope: :user_id
end
