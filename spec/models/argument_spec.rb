require 'rails_helper'

RSpec.describe Argument, type: :model do
  it "is valid with target, and topic" do
    expect(build(:argument)).to be_valid
  end

  it "is invalid without target" do
    argument = build(:nil_target_argument)
    argument.valid?
    expect(argument.errors[:target]).to include("を入力してください")
  end

  it "is invalid without topic" do
    argument = build(:nil_topic_argument)
    argument.valid?
    expect(argument.errors[:topic]).to include("を入力してください")
  end

  it "is invalid less than 5" do
    argument = build(:argument, topic: "1234")
    argument.valid?
    expect(argument.errors[:topic]).to include("は5文字以上で入力してください")
  end

  it "is invalid more than 20" do
    argument = build(:argument, topic: "hellohellohellohellohello")
    argument.valid?
    expect(argument.errors[:topic]).to include("は20文字以内で入力してください")
  end
end
