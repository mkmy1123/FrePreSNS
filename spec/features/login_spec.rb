require 'rails_helper'

RSpec.feature "login/logout", type: :feature do
  include Devise::Test::IntegrationHelpers
  background do
    @user = FactoryBot.create(:user)
  end
  scenario "The user able to log in" do
    visit root_path
    click_link "LOG IN"
    fill_in "ID", with: @user.optional_id
    fill_in "Password", with: @user.password
    click_button "ログインする"
    expect(page).to have_content "ログイン成功"
  end
  scenario "The user able to logout" do
    sign_in @user
    visit root_path
    click_link "LOG OUT"
    expect(page).to have_content "ログアウトしました"
  end
end
