require 'rails_helper'

RSpec.describe Expression, type: :model do
  it "is valid with statement" do
    expect(build(:expression)).to be_valid
  end

  it "is valid with statement, detail" do
    expect(build(:expression, :add_detail)).to be_valid
  end

  it "is valid with statement, position_of" do
    expect(build(:expression, :add_position_of)).to be_valid
  end

  it "is valid with all optional data" do
    expect(build(:expression, :add_detail, :add_position_of)).to be_valid
  end

  it "is invalid without a statement" do
    expression = build(:expression, statement: nil)
    expression.valid?
    expect(expression.errors[:statement]).to include("を入力してください")
  end

  it "is invalid without a position_of" do
    expression = build(:expression, position_of: nil)
    expression.valid?
    expect(expression.errors[:position_of]).to include("を入力してください")
  end
end
