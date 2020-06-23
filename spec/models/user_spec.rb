require 'rails_helper'

RSpec.describe User, type: :model do
  it "is valid with correct infomation" do
    expect(FactoryBot.build(:user)).to be_valid
  end

  it "is invalid without a optional_id" do
    user = build(:user, optional_id: nil)
    user.valid?
    expect(user.errors[:optional_id]).to include("を入力してください")
  end

  it "is invalid without a name" do
    user = build(:user, name: nil)
    user.valid?
    expect(user.errors[:name]).to include("を入力してください")
  end

  it "is invalid without a email" do
    user = build(:user, email: nil)
    user.valid?
    expect(user.errors[:email]).to include("を入力してください")
  end

  it "is invalid with a duplicate optional_id" do
    create(:user, optional_id: "testtest")
    user = build(:user, optional_id: "testtest")
    user.valid?
    expect(user.errors[:optional_id]).to include("はすでに存在します")
  end

  it "is invalid with a optional_id written in Japanese" do
    user = build(:user, optional_id: "テストID")
    user.valid?
    expect(user.errors[:optional_id]).to include("半角英数字とハイフン(-)のみが使えます")
  end

  it "is invalid intrudction more than 200" do
    user = build(:introduction_user)
    user.valid?
    expect(user.errors[:introduction]).to include("10字以上200字以内で記入してください")
  end

  it "is invalid intrudction less than 10" do
    user = build(:user, introduction: "hello")
    user.valid?
    expect(user.errors[:introduction]).to include("10字以上200字以内で記入してください")
  end
end
