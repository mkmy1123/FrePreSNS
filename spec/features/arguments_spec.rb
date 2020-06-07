require 'rails_helper'

RSpec.feature "Arguments", type: :feature do
  include Devise::Test::IntegrationHelpers
  background do
    user = FactoryBot.create(:user)
    sign_in user
  end
  scenario "The user creates a new argument" do
    visit root_path
    click_link "ARGUMENTS"
    expect(page).to have_content "論点は簡潔に！"
    find_field("今回の論点").set('テストの論点です。')
    click_button "送信"
    expect(page).to have_content "テストの論点です。"
    expect(page).to have_content "が投稿できました"
  end
end
