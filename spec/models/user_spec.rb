require 'rails_helper'

# 最初の簡単なテストなので条件文を英語で挑戦して書いてみてます
RSpec.describe User, type: :model do
  it "is valid with optional_id, name, email, password, and  password_comfimation" do
    user = User.new(
      name: "test",
      email: "test@test.com",
      optional_id: "test0001",
      password: "testtest",
      password_confirmation: "testtest"
    )
    expect(user).to be_valid
  end

  it "is invalid without a optional_id" do
    user = User.new(optional_id: nil)
    user.valid?
    expect(user.errors[:optional_id]).to include("を入力してください")
  end

  it "is invalid without a name" do
    user = User.new(name: nil)
    user.valid?
    expect(user.errors[:name]).to include("を入力してください")
  end

  it "is invalid without a email" do
    user = User.new(email: nil)
    user.valid?
    expect(user.errors[:email]).to include("を入力してください")
  end

  it "is invalid with a duplicate optional_id" do
    User.create(
      name: "test",
      email: "test@test.com",
      optional_id: "test0001",
      password: "testtest",
      password_confirmation: "testtest"
    )
    user = User.new(
      name: "test2",
      email: "test2@test.com",
      optional_id: "test0001",
      password: "test2test2",
      password_confirmation: "test2test2"
    )
    user.valid?
    expect(user.errors[:optional_id]).to include("はすでに存在します")
  end

  it "is invalid with a optional_id written in Japanese" do
    user = User.new(
      name: "test2",
      email: "test@test.com",
      optional_id: "テストテストID",
      password: "test2test2",
      password_confirmation: "test2test2"
    )
    user.valid?
    expect(user.errors[:optional_id]).to include("半角英数字のみが使えます")
  end

  it "is invalid intrudction more than 200" do
    user = User.new(
      name: "test",
      email: "test@test.com",
      optional_id: "test0001",
      introduction: "hellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohellphello",
      password: "test2test2",
      password_confirmation: "test2test2"
    )
    user.valid?
    expect(user.errors[:introduction]).to include("10字以上200字以内で記入してください")
  end

  it "is invalid intrudction less than 10" do
    user = User.new(
      name: "test",
      email: "test@test.com",
      optional_id: "test0001",
      introduction: "hello",
      password: "test2test2",
      password_confirmation: "test2test2"
    )
    user.valid?
    expect(user.errors[:introduction]).to include("10字以上200字以内で記入してください")
  end
end
