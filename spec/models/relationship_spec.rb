require 'rails_helper'

RSpec.describe Relationship, type: :model do
  before do
    @user = create(:user)
    @user2 = create(:user)
  end

  describe "exsisting two users" do
    it "is valid" do
      expect(@user.relationships.build(trust_id: @user2.id)).to be_valid
    end

    it "is valid with trust method" do
      @user.trust(@user2)
      expect(@user.trusting?(@user2)).to eq(true)
    end

    context "Already trusting" do
      it "is trusting? method to get correct info" do
        @user.relationships.create(trust_id: @user2.id)
        expect(@user.trusting?(@user2)).to eq(true)
      end
      it "is valid with untrust method" do
        @user.relationships.create(trust_id: @user2.id)
        @user.untrust(@user2)
        expect(@user.trusting?(@user2)).to eq(false)
      end
    end
  end
end
