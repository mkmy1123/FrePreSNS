FactoryBot.define do
  factory :event do
    title { "MyString" }
    sequence(:start_time, Date.today.next_day(10))
    sequence(:end_time, Date.today.next_day(10))
    all_day { false }
    description { "MyText" }
    association :argument
    association :user

    factory :nil_title_event do
      title { nil }
    end
  end
end
