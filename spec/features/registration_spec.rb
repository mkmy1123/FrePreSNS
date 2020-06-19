require 'rails_helper'

RSpec.feature "registration", type: :feature do
  include Devise::Test::IntegrationHelpers
  describe 'signup' do
    let(:user) { create(:user) }
    let(:other_user) { create(:user) }

    scenario "The user sign up" do
      visit root_path
      click_link "SIGN UP"
      fill_in "Email メールアドレス", with: "test@test.com"
      fill_in "Name 名前", with: "テストさん"
      fill_in "ID ログイン用", with: "test0001"
      fill_in "Passwpord パスワード", with: "testtest"
      fill_in "Password 確認用", with: "testtest"
      click_button "登録する"
      expect(page).to have_content "アカウント登録"
    end

    scenario "After resistration, the user recieve welcome_mail" do
      visit root_path
      click_link "SIGN UP"
      fill_in "Email メールアドレス", with: "test@test.com"
      fill_in "Name 名前", with: "テストさん"
      fill_in "ID ログイン用", with: "test0001"
      fill_in "Passwpord パスワード", with: "testtest"
      fill_in "Password 確認用", with: "testtest"
      expect { click_button "登録する" }.to change { ActionMailer::Base.deliveries.count }.by(1)
    end

    scenario "After resistration, the user page exists" do
      sign_in user
      visit user_path(user)
      expect(current_url).to have_content(user.optional_id)
    end

    scenario "After resistration, the user avator is default image" do
      visit user_path(user)
      expect(page).to have_css("img[src*='default']")
    end

    scenario "After resistration, other user is able to trust" do
      visit root_path
      click_link "SIGN UP"
      fill_in "Email メールアドレス", with: "test@test.com"
      fill_in "Name 名前", with: "テストさん"
      fill_in "ID ログイン用", with: "test1010"
      fill_in "Passwpord パスワード", with: "testtest"
      fill_in "Password 確認用", with: "testtest"
      click_button "登録する"
      click_link "LOG OUT"
      sign_in other_user
      visit user_path("test1010")
      click_button "信用する"
      expect(page).to have_content "TRUSTED | 1"
    end
  end

  describe 'Logic delete' do
    let(:user) { create(:user) }
    let(:other_user) { create(:user) }
    let!(:invalid_user) { create(:invalid_user) }

    scenario "The user delete in the logic" do
      sign_in user
      visit root_path
      click_link "DELETE USER アカウントの削除"
      click_link "アカウントの削除"
      expect(page).to have_content "退会手続きができました"
    end

    scenario "Deleted user isn't able to login" do
      visit root_path
      click_link "LOG IN"
      fill_in "ID", with: invalid_user.optional_id
      fill_in "Password", with: invalid_user.password
      click_button "ログインする"
      expect(find('.alert')).to have_content "退会済みです"
    end

    scenario "Deleted user page exist, but consists of words: Deleted" do
      visit user_path(invalid_user)
      expect(page).to have_content "退会済み"
    end

    scenario "Deleted user page don't has trust button" do
      sign_in user
      visit user_path(invalid_user)
      expect(page).to have_no_button "信用する"
    end
  end
end
