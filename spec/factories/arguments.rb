FactoryBot.define do
  factory :argument do
    target { 1 }
    sequence(:topic) { |n| "#{n}について" }

    factory :nil_target_argument do
      target { nil }
    end

    factory :nil_topic_argument do
      topic { nil }
    end

    factory :tag_argument do
      topic { "こんにちは世界" }
      tag_list { "新しい" }
    end
  end
end
