require 'rails_helper'

RSpec.describe Component, type: :model do
  it "is valid with correct infomation" do
    expect(build(:component)).to be_valid
  end

  it "is invalid without title" do
    component = build(:nil_title_component)
    component.valid?
    expect(component.errors[:title]).to include("を入力してください")
  end

  it "is invalid without kind_of" do
    component = build(:nil_kind_of_component)
    component.valid?
    expect(component.errors[:kind_of]).to include("を入力してください")
  end

  it "is invalid without description" do
    component = build(:nil_description_component)
    component.valid?
    expect(component.errors[:description]).to include("を入力してください")
  end

  it "is invalid title more than 20" do
    component = build(:over_title_component)
    component.valid?
    expect(component.errors[:title]).to include("は20文字以内で入力してください")
  end
end
