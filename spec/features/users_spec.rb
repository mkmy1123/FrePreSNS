require 'rails_helper'

RSpec.feature "Users", type: :feature do
  scenario "user able to login" do
    user = FactoryBot.create(:user)
    visit root_path
    click_link "LOG IN"
    fill_in "ID", with: user.optional_id
    fill_in "Password", with: user.password
    click_button "ログインする"
    expect(page).to have_content "ログイン成功"
  end
end
