FactoryBot.define do
  factory :component do
    association :user
    kind_of { 1 }
    sequence(:title) { |n| "わたしの#{n}" }
    sequence(:description) { |n| "#{n}がとっても好きなんです" }

    factory :nil_title_component do
      title { nil }
    end

    factory :nil_kind_of_component do
      kind_of { nil }
    end

    factory :nil_description_component do
      description { nil }
    end

    factory :over_title_component do
      title { "hellohellohellohello!" }
    end

    factory :little_title_component do
      title { "hell" }
    end
  end
end