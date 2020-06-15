require 'rails_helper'

RSpec.feature "Users", type: :feature do
  include Devise::Test::IntegrationHelpers

  describe 'User edit' do
    let(:user) { create(:user) }
    scenario "Page have edit button" do
      sign_in user
      visit user_path(user)
      expect(page).to have_content '編集'
    end

    scenario "User update infomation :name" do
      sign_in user
      visit user_path(user)
      click_on '編集'
      fill_in '名前', with: 'とんすけ'
      click_on '編集する'
      visit user_path(user)
      expect(page).to have_content 'とんすけ'
    end

    scenario "User update infomation :optional_id" do
      sign_in user
      visit user_path(user)
      click_on '編集'
      fill_in 'ID', with: 'tonsuke1010'
      click_button '編集する'
      expect(page).to have_content 'tonsuke1010'
      expect(current_url).to have_content('tonsuke1010')
    end

    scenario "User update no infomation :intruduction" do
      sign_in user
      visit user_path(user)
      click_on '編集'
      fill_in '自己紹介', with: ''
      click_button '編集する'
      expect(page).to have_content 'USER情報が更新されました！'
    end

    scenario "User update infomation :intruduction" do
      sign_in user
      visit user_path(user)
      click_on '編集'
      fill_in '自己紹介', with: 'こんにちは、とんすけです。'
      click_button '編集する'
      expect(page).to have_content 'こんにちは、とんすけです。'
    end
  end
end
