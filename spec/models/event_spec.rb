require 'rails_helper'

RSpec.describe Event, type: :model do
  it "is valid with correct infomation" do
    expect(build(:event)).to be_valid
  end

  it "is invalid without title" do
    event = build(:nil_title_event)
    event.valid?
    expect(event.errors[:title]).to include("を入力してください")
  end

  it "is invalid a long title" do
    event = build(:short_title)
    event.valid?
    expect(event.errors[:title]).to include("は5文字以上で入力してください")
  end

  it "is invalid a long title" do
    event = build(:long_title)
    event.valid?
    expect(event.errors[:title]).to include("は20文字以内で入力してください")
  end

  it "is invalid without description" do
    event = build(:nil_description_event)
    event.valid?
    expect(event.errors[:description]).to include("を入力してください")
  end

  it "is invalid without start_time" do
    event = build(:nil_start_time_event)
    event.valid?
    expect(event.errors[:start_time]).to include("を入力してください")
  end

  it "is invalid without end_time" do
    event = build(:nil_end_time_event)
    event.valid?
    expect(event.errors[:end_time]).to include("を入力してください")
  end

  it "is invalid end_time before start_time" do
    event = build(:over_time)
    event.valid?
    expect(event.errors[:end_time]).to include("に開始時間より過去の日付は使えません")
  end

  it "is invalid past start_time" do
    event = build(:past_start_time)
    event.valid?
    expect(event.errors[:start_time]).to include("に過去の日付は使えません")
  end

  it "is invalid past end_time" do
    event = build(:past_end_time)
    event.valid?
    expect(event.errors[:end_time]).to include("に過去の日付は使えません")
  end
end
