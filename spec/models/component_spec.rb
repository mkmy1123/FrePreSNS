require 'rails_helper'

RSpec.describe Component, type: :model do
  it "is valid with title, description, and kind_of" do
    expect(FactoryBot.build(:component)).to be_valid
  end

  it "is invalid without title" do
    component = FactoryBot.build(:nil_title_component)
    component.valid?
    expect(component.errors[:title]).to include("を入力してください")
  end

  it "is invalid without kind_of" do
    component = FactoryBot.build(:nil_kind_of_component)
    component.valid?
    expect(component.errors[:kind_of]).to include("を入力してください")
  end

  it "is invalid without description" do
    component = FactoryBot.build(:nil_description_component)
    component.valid?
    expect(component.errors[:description]).to include("を入力してください")
  end

  it "is invalid title less than 5" do
    component = FactoryBot.build(:little_title_component)
    component.valid?
    expect(component.errors[:title]).to include("は5文字以上で入力してください")
  end

  it "is invalid title more than 20" do
    component = FactoryBot.build(:over_title_component)
    component.valid?
    expect(component.errors[:title]).to include("は20文字以内で入力してください")
  end

  it "is invalid description less than 5" do
    component = FactoryBot.build(:little_description_component)
    component.valid?
    expect(component.errors[:description]).to include("は5文字以上で入力してください")
  end
end