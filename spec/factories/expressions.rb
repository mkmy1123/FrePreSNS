FactoryBot.define do
  factory :expression do
    sequence(:statement) { |n| "おかしいと思う#{n}について" }
    association :user
    association :argument

    trait :add_detail do
      sequence(:detail) { |n| "#{n}はやっぱりどうしてもおかしい" }
    end

    trait :add_position_of do
      position_of { 2 }
    end
  end
end
