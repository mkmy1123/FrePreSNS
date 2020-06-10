class Notification < ApplicationRecord
  default_scope -> { order(created_at: :desc) }
  belongs_to :argument, optional: true
  belongs_to :expression, optional: true
  belongs_to :event, optional: true
  belongs_to :event_comment, optional: true

  belongs_to :visitor, class_name: 'User', foreign_key: 'visitor_id', optional: true
  belongs_to :visited, class_name: 'User', foreign_key: 'visited_id', optional: true
end
