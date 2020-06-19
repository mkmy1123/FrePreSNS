require 'rails_helper'

RSpec.feature "Around users", type: :feature do
  include Devise::Test::IntegrationHelpers
  background do
    @user = create(:example_user)
  end

  describe 'As edit action' do
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

    scenario "User update infomation :avatar" do
      sign_in user
      visit user_path(user)
      click_on '編集'
      attach_file 'avatar', "#{Rails.root}/spec/factories/avatar_image.png"
      click_button '編集する'
      expect(page).to have_css("img[src*='avatar_image']")
    end
  end

  describe "As index action" do
    let(:user) { create(:user) }

    scenario "Searching user_name's search form, user info hits" do
      visit users_path
      fill_in 'うろ覚えの名前 :', with: user.name
      click_button '検索'
      expect(page).to have_content user.name
      expect(page).to have_content user.optional_id
      expect(page).not_to have_content @user.optional_id
      fill_in 'うろ覚えの名前 :', with: '架空の名前'
      click_button '検索'
      expect(page).to have_content 'Not found'
      expect(page).not_to have_content user.optional_id
      expect(page).not_to have_content @user.optional_id
    end

    scenario "Searching user_optional_id's search form, user info hits" do
      visit users_path
      fill_in 'うろ覚えのID :', with: user.optional_id
      click_button '検索'
      expect(page).to have_content user.name
      expect(page).to have_content user.optional_id
      expect(page).not_to have_content @user.optional_id
      fill_in 'うろ覚えのID :', with: '架空のID'
      click_button '検索'
      expect(page).to have_content 'Not found'
      expect(page).not_to have_content user.optional_id
      expect(page).not_to have_content @user.optional_id
    end

    scenario "Clicked searched result, page is result's user" do
      visit users_path
      fill_in 'うろ覚えのID :', with: @user.optional_id
      click_button '検索'
      click_on @user.optional_id
      expect(current_url).to have_content(@user.optional_id)
      expect(page).to have_content 'USER INFOMATION'
    end
  end

  describe "As show action" do
    let(:user) { create(:user) }

    scenario "User is current_user, page has edit button" do
      sign_in @user
      visit user_path(@user)
      link = find('#edit_btn')
      expect(link[:href]).to eq edit_user_path(@user)
      sign_in user
      visit user_path(@user)
      expect(page).not_to have_css '#edit_btn'
    end

    scenario "User is current_user, page has the form to add component" do
      sign_in @user
      visit user_path(@user)
      expect(page).to have_content '自分のコンポーネントを追加'
      sign_in user
      visit user_path(@user)
      expect(page).not_to have_content '自分のコンポーネントを追加'
    end
  end
end
