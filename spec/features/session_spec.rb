require 'rails_helper'

RSpec.feature "session", type: :feature do
  include Devise::Test::IntegrationHelpers
  background do
    @user = FactoryBot.create(:user)
  end

  describe 'login' do
    scenario "The user able to log in" do
      visit root_path
      click_link "LOG IN"
      fill_in "ID", with: @user.optional_id
      fill_in "Password", with: @user.password
      click_button "ログインする"
      expect(page).to have_content "ログイン成功"
    end

    scenario "Log in user, top page has the user's optional_id" do
      sign_in @user
      visit root_path
      expect(page).to have_content "Login now : #{@user.optional_id}"
    end

    scenario "Log in user, page don't has login link" do
      visit root_path
      expect(page).to have_link "LOG IN"
      sign_in @user
      visit root_path
      expect(page).not_to have_link "LOG IN"
    end
  end

  describe 'logout' do
    scenario "The user able to logout" do
      sign_in @user
      visit root_path
      click_link "LOG OUT"
      expect(page).to have_content "ログアウトしました"
    end

    scenario "Log out user, top page hasnot the user's optional_id" do
      sign_in @user
      visit root_path
      click_link "LOG OUT"
      expect(page).not_to have_content "Login now : #{@user.optional_id}"
    end

    scenario "Log out user, page don't has logout link" do
      sign_in @user
      visit root_path
      expect(page).to have_link "LOG OUT"
      click_link "LOG OUT"
      visit root_path
      expect(page).not_to have_link "LOG OUT"
    end
  end
end
