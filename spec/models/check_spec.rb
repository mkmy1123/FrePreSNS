require 'rails_helper'

RSpec.describe Check, type: :model do
  context "existing argument and user" do
    before do
      @user = create(:user)
      @argument = create(:argument)
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
