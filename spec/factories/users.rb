FactoryBot.define do
  factory :user do
    sequence(:name) { |n| "TEST#{n}"}
    sequence(:email) { |n| "TEST#{n}@example.com"}
    sequence(:optional_id) { |n| "TEST000#{n}"}
    sequence(:password) { |n| "TEST000#{n}"}
    sequence(:password_confirmation) { |n| "TEST000#{n}"}
  end
end