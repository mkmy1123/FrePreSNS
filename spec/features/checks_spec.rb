require 'rails_helper'

RSpec.feature "Checks", type: :feature do
  scenario "user creates a new argument, and checks the argument" do
    user = FactoryBot.create(:user)
    visit root_path
    click_link "LOG IN"
    fill_in "ID", with: user.optional_id
    fill_in "Password", with: user.password
    click_button "ログインする"
    click_link "ARGUMENTS"
    expect(page).to have_content "論点は簡潔に！"
    find_field("今回の論点").set('テストの論点です。')
    click_button "送信"
    expect(page).to have_content "テストの論点です。"
    expect(page).to have_content "が投稿できました"
    find_by_id('check_btn').click
    expect(page).to have_content "CHECK済"
  end
end
