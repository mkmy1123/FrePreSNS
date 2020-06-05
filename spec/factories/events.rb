FactoryBot.define do
  factory :event do
    title { "MyString" }
    start_time { "2020-06-04 01:55:51" }
    end_time { "2020-06-04 01:55:51" }
    all_day { false }
    description { "MyText" }
    association :argument
    association :user

    factory :nil_title_event do
      title { nil }
    end
  end
end
