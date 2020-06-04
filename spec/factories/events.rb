FactoryBot.define do
  factory :event do
    title { "MyString" }
    start { "2020-06-04 01:55:51" }
    finish { "2020-06-04 01:55:51" }
    allDay { false }
    description { "MyText" }
  end
end
