require 'rails_helper'

RSpec.feature "Around arguments", type: :feature do
  include Devise::Test::IntegrationHelpers

  background do
    @user = create(:user)
    sign_in @user
    @argument = create(:tag_argument)
  end
  describe "#index" do
    let(:argument) { create(:argument) }

    context "By signed_in_user" do
      scenario "Page has submit btn" do
        sign_out @user
        visit arguments_path
        expect(page).to have_content "ログインすると投稿できるようになります"
        expect(page).not_to have_button "送信"
      end

      scenario "User creates a new argument" do
        visit root_path
        click_link "ARGUMENTS"
        expect(page).to have_content "論点は簡潔に！"
        find_field("論点").set('テストの論点です。')
        click_button "送信"
        expect(page).to have_content "テストの論点です。"
        expect(page).to have_content "が投稿できました"
      end

      scenario "Submit expression, argument increases counts" do
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
        expect('.content').to have_no_css ".fa-check-circle"
      end
    end

    context "Using search function" do
      scenario "NAME search, the result is corrent" do
        visit arguments_path
        fill_in "言いたいこと", with: @argument.topic
        click_button "検索"
        expect(page).to have_content "こんにちは世界"
        fill_in "言いたいこと", with: "存在しない内容です"
        click_button "検索"
        expect(page).not_to have_content "こんにちは世界"
      end

      scenario "TARGET search, the result is corrent" do
        visit arguments_path
        expect(page).to have_content "こんにちは世界"
        select "思想", from: 'target'
        click_button "GO"
        expect(page).not_to have_content "こんにちは世界"
      end

      scenario "TAG search, only argument related tag" do
        visit arguments_path(tag: "新しい")
        expect(page).to have_content "こんにちは世界"
        expect(page).not_to have_content argument.topic
      end

      scenario "Search NO result, but find page back" do
        visit arguments_path
        fill_in "言いたいこと", with: "存在しないトピック"
        click_button "検索"
        expect(page).to have_content "Sorry, Not found"
        expect(page).not_to have_content "こんにちは世界"
        click_link "一覧に戻す"
        expect(page).not_to have_content "Sorry, Not found"
        expect(page).to have_content "こんにちは世界"
      end
    end
  end

  describe "#show" do
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
      expect('.content').to have_no_css ".fa-check-circle"
    end
  end
end
