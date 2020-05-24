FactoryBot.define do
  factory :expression do
    sequence(:statement) { |n| "おかしいと思う#{n}について" }
    sequence(:detail) { |n| "#{n}はやっぱりどうしてもおかしい" }
    association :user
    association :argument
  end
end
