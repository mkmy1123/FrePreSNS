require 'rails_helper'

RSpec.feature "Around relationship functions", type: :feature do
  include Devise::Test::IntegrationHelpers

  before do
    @user = create(:user)
    @user2 = create(:user)
    sign_in @user
  end

  scenario "The user trust the other user" do
    visit user_path(@user2)
    expect(page).to have_content "TRUSTED | 0"
    click_button "信用する"
    expect(page).to have_content "TRUSTED | 1"
  end

  scenario "The user untrust the other user" do
    @user.trust(@user2)
    visit user_path(@user2)
    expect(page).to have_content "TRUSTED | 1"
    click_button "信用を外す"
    expect(page).to have_content "TRUSTED | 0"
  end
end
