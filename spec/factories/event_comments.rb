FactoryBot.define do
  factory :event_comment do
    association :user
    association :event
    body { "どんな内容で行うのですか？" }
  end
end
