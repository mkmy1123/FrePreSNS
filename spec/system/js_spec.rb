require 'rails_helper'

RSpec.feature "relationships", type: :system do
  include Devise::Test::IntegrationHelpers
  before do
    @user = create(:user)
    @user2 = create(:user)
    sign_in @user
  end

  scenario "The user trust the other user, in js", js: true do
    visit user_path(@user2)
    click_button "信用する"
    sleep 3
    expect(page).to have_css('.notice')
  end

  scenario "The user untrust the other user, in js", js: true do
    @user.trust(@user2)
    visit user_path(@user2)
    expect(page).to have_content "TRUSTED | 1"
    click_button "信用を外す"
    sleep 3
    expect(page).to have_css('.notice')
  end
end
