require 'rails_helper'

# 最初の簡単なテストなので条件文を英語で挑戦して書いてみてます
RSpec.describe User, type: :model do
  it "is valid with optional_id, name, email, password, and  password_comfimation" do
    expect(FactoryBot.build(:user)).to be_valid
  end

  it "is invalid without a optional_id" do
    user = FactoryBot.build(:user, optional_id: nil)
    user.valid?
    expect(user.errors[:optional_id]).to include("を入力してください")
  end

  it "is invalid without a name" do
    user = FactoryBot.build(:user, name: nil)
    user.valid?
    expect(user.errors[:name]).to include("を入力してください")
  end

  it "is invalid without a email" do
    user = FactoryBot.build(:user, email: nil)
    user.valid?
    expect(user.errors[:email]).to include("を入力してください")
  end

  it "is invalid with a duplicate optional_id" do
    FactoryBot.create(:user, optional_id: "testtest")
    user = FactoryBot.build(:user, optional_id: "testtest")
    user.valid?
    expect(user.errors[:optional_id]).to include("はすでに存在します")
  end

  it "is invalid with a optional_id written in Japanese" do
    user = FactoryBot.build(:user, optional_id: "テストID")
    user.valid?
    expect(user.errors[:optional_id]).to include("半角英数字のみが使えます")
  end

  it "is invalid intrudction more than 200" do
    user = FactoryBot.build(:intrpduction_user)
    user.valid?
    expect(user.errors[:introduction]).to include("10字以上200字以内で記入してください")
  end

  it "is invalid intrudction less than 10" do
    user = FactoryBot.build(:user, introduction: "hello")
    user.valid?
    expect(user.errors[:introduction]).to include("10字以上200字以内で記入してください")
  end
end
