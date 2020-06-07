FactoryBot.define do
  factory :user do
    sequence(:name) { |n| "User#{n}" }
    sequence(:email) { |n| "tester#{n}@example.com" }
    sequence(:optional_id) { |n| "test000#{n}" }
    password { "testtest" }
    password_confirmation { "testtest" }

    factory :introduction_user do
      introduction { "hellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohellphello" }
    end

    factory :invalid_user do
      is_valid { false }
    end
  end
end
