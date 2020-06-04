class Event < ApplicationRecord
  belongs_to :argument
  belongs_to :user
end
