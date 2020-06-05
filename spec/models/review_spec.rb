require 'rails_helper'

RSpec.describe Review, type: :model do
  context "when argument, expression and user exsists" do
    before do
      @user = FactoryBot.create(:user)
      @expression = FactoryBot.create(:expression)
    end

    it "is valid with corrent infomations" do
      expect(@user.reviews.build(expression_id: @expression.id, rate: 5)).to be_valid
    end

    it "is invalid with no rate" do
      review = @user.reviews.build(expression_id: @expression.id)
      review.valid?
      expect(review.errors[:rate]).to include("を入力してください")
    end

    it "is invalid with rate in string" do
      review = @user.reviews.build(expression_id: @expression.id, rate: "５")
      review.valid?
      expect(review.errors[:rate]).to include("は数値で入力してください")
    end
  end
end
