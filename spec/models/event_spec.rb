require 'rails_helper'

RSpec.describe Event, type: :model do
  it "is valid with argument, and correct-infomations" do
    expect(FactoryBot.build(:event)).to be_valid
  end

  it "is invalid without title" do
    event = FactoryBot.build(:nil_title_event)
    event.valid?
    expect(event.errors[:title]).to include("を入力してください")
  end
end
