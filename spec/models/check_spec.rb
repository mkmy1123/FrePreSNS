require 'rails_helper'

RSpec.describe Check, type: :model do
  context "when argument and user exsists" do
    before do
      @user = FactoryBot.create(:user)
      @argument = FactoryBot.create(:argument)
    end

    it "is valid with correct infomation" do
      expect(@user.checks.build(argument_id: @argument.id)).to be_valid
    end

    it "is valid, then checked? is valid method" do
      @user.checks.create(argument_id: @argument.id)
      expect(@user.checked?(@argument)).to eq(true)
    end
  end
end
