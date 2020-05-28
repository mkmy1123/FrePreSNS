require 'rails_helper'

RSpec.describe Expression, type: :model do
  it "is valid with statement" do
    expect(FactoryBot.build(:expression)).to be_valid
  end

  it "is valid with statement, detail" do
    expect(FactoryBot.build(:expression, :add_detail)).to be_valid
  end

  it "is valid with statement, position_of" do
    expect(FactoryBot.build(:expression, :add_position_of)).to be_valid
  end

  it "is valid with all optional data" do
    expect(FactoryBot.build(:expression, :add_detail, :add_position_of)).to be_valid
  end
end
