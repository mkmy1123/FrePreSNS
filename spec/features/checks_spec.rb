require 'rails_helper'

RSpec.feature "Checks", type: :feature do
  include Devise::Test::IntegrationHelpers

  background do
    @user = create(:user)
    sign_in @user
    @argument = create(:tag_argument)
  end

  describe "By signed in user" do
    scenario "user checks the argument" do
      visit arguments_path
      expect(page).to have_content @argument.topic
      expect { find('#check_btn').click }.to change(Check, :count).by(1)
    end

    scenario "user unchecks the argument" do
      @user.checks.create(argument_id: @argument.id)
      visit arguments_path
      expect(page).to have_content @argument.topic
      expect(page).to have_content "CHECK済"
      expect { find('#uncheck_btn').click }.to change(Check, :count).by(-1)
    end
  end

  describe "By NOT signed in user" do
    scenario "Page doesn't have check_btn" do
      sign_out @user
      visit arguments_path
      expect(page).to have_content @argument.topic
      expect(page).not_to have_css '#check_btn'
      expect(page).not_to have_css '#uncheck_btn'
    end
  end
end
