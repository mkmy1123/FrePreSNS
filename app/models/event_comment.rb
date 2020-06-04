class EventComment < ApplicationRecord
  belongs_to :user
  belongs_to :event

  belongs_to :dear_user, class_name: 'User', optional: true
end
