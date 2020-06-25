FactoryBot.define do
  factory :event do
    title { "楽しいイベント" }
    sequence(:start_time, Date.today.next_day(10))
    sequence(:end_time, Date.today.next_day(10))
    all_day { false }
    description { "楽しすぎるのできたほうがいいです" }
    association :argument
    association :user

    factory :nil_title_event do
      title { nil }
    end

    factory :short_title do
      title { "hell" }
    end

    factory :long_title do
      title { "hellohellohellohelloh" }
    end

    factory :nil_description_event do
      description { nil }
    end

    factory :nil_start_time_event do
      start_time { nil }
    end

    factory :nil_end_time_event do
      end_time { nil }
    end

    factory :over_time do
      start_time { Date.today.next_day(10) }
      end_time { Date.today.next_day(1) }
    end

    factory :past_start_time do
      start_time { Date.yesterday }
    end

    factory :past_end_time do
      end_time { Date.yesterday }
    end
  end
end
