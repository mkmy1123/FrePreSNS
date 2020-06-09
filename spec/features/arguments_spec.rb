require 'rails_helper'

RSpec.feature "Arguments", type: :feature do
  include Devise::Test::IntegrationHelpers

  background do
    @user = FactoryBot.create(:user)
    sign_in @user
    @argument = FactoryBot.create(:tag_argument)
  end
  describe "Action as index page" do
    let(:argument){ FactoryBot.create(:argument) }

    scenario "Only signed_in_user get submit btn" do
      sign_out @user
      visit arguments_path
      expect(page).to have_content "ログインすると投稿できるようになります"
      expect(page).not_to have_button "送信"
    end

    scenario "Signed_in_user creates a new argument" do
      visit root_path
      click_link "ARGUMENTS"
      expect(page).to have_content "論点は簡潔に！"
      find_field("論点").set('テストの論点です。')
      click_button "送信"
      expect(page).to have_content "テストの論点です。"
      expect(page).to have_content "が投稿できました"
    end

    scenario "Using argument search(name), the result is corrent" do
      visit arguments_path
      fill_in "言いたいこと", with: @argument.topic
      click_button "検索"
      expect(page).to have_content "こんにちは世界"
      fill_in "言いたいこと", with: "存在しない内容です"
      click_button "検索"
      expect(page).not_to have_content "こんにちは世界"
    end

    scenario "Using argument search(target), the result is corrent" do
      visit arguments_path
      expect(page).to have_content "こんにちは世界"
      select "思想", from: 'target'
      click_button "GO"
      expect(page).not_to have_content "こんにちは世界"
    end

    scenario "Clicked argument tag, page is only argument related tag" do
      visit arguments_path(tag: "新しい")
      expect(page).to have_content "こんにちは世界"
      expect(page).not_to have_content argument.topic
    end

    scenario "Search no result, but find page back" do
      visit arguments_path
      fill_in "言いたいこと", with: "存在しないトピック"
      click_button "検索"
      expect(page).to have_content "Sorry, Not found"
      expect(page).not_to have_content "こんにちは世界"
      click_link "一覧に戻す"
      expect(page).not_to have_content "Sorry, Not found"
      expect(page).to have_content "こんにちは世界"
    end

    scenario "Submit expression, arguments index increase count" do
      visit argument_path(@argument)
      fill_in "簡単にいうと(要点)", with: "Expressionを投稿する"
      click_button "みんなに伝える"
      visit arguments_path
      expect(page).to have_content "中立 1"
      expect(page).not_to have_content "中立 0"
    end

    scenario "Checked the argument already, uncheck btn exists" do
      @user.checks.create(argument_id: @argument.id)
      visit argument_path(@argument)
      expect(page).to have_content "CHECK済"
      expect(page).to have_no_css ".fa-check-circle"
    end
  end

  describe "Action as show page" do
    scenario "Argument exists, only signed_in_user get button" do
      sign_out @user
      visit argument_path(@argument)
      expect(page).to have_content "ログインすると投稿できるようになります"
      expect(page).not_to have_button "みんなに伝える"
    end

    scenario "Checked the argument already, uncheck btn exists" do
      @user.checks.create(argument_id: @argument.id)
      visit argument_path(@argument)
      expect(page).to have_content "CHECK済"
      expect(page).to have_no_css ".fa-check-circle"
    end
  end
end
