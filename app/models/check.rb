class Check < ApplicationRecord
  belongs_to :user
  belongs_to :argument

  validates_uniqueness_of :argument_id, scope: :user_id
end
