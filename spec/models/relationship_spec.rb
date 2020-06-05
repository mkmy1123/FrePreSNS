require 'rails_helper'

RSpec.describe Relationship, type: :model do
  context "when two user exsist" do
    before do
      @user = FactoryBot.create(:user)
      @user2 = FactoryBot.create(:user)
    end

    it "is valid" do
      expect(@user.relationships.build(trust_id: @user2.id)).to be_valid
    end

    it "exsist relationship, then trusting? is valid method" do
      @user.relationships.create(trust_id: @user2.id)
      expect(@user.trusting?(@user2)).to eq(true)
    end

    it "is valid with trust method" do
      @user.trust(@user2)
      expect(@user.trusting?(@user2)).to eq(true)
    end

    it "exsist relationship, then untrust is valid method" do
      @user.relationships.create(trust_id: @user2.id)
      @user.untrust(@user2)
      expect(@user.trusting?(@user2)).to eq(false)
    end
  end
end
