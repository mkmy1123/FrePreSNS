require 'rails_helper'

RSpec.feature "Expressions", type: :feature do
  include Devise::Test::IntegrationHelpers

  background do
    @user = create(:user)
    @argument = create(:tag_argument)
    @expression = create(:positive_expression)
    sign_in @user
  end

  describe "Flow around create" do
    scenario "Signed_in_user create expresssion" do
      visit argument_path(@argument)
      fill_in "簡単にいうと(要点) :", with: "初めての投稿"
      click_button "みんなに伝える"
      expect(find('.notice')).to have_content "おめでとうございます"
      expect(page).to have_content "初めての投稿"
    end

    scenario "Signed_in_user create not enogh expresssion" do
      visit argument_path(@argument)
      fill_in "簡単にいうと(要点) :", with: ""
      click_button "みんなに伝える"
      expect(page).to have_content "要点を入力してください"
      fill_in "簡単にいうと(要点) :", with: "初"
      click_button "みんなに伝える"
      expect(page).to have_content "要点は5文字以上で入力してください"
    end

    scenario "Signed_in_user create negative expresssion" do
      visit argument_path(@argument)
      find_by_id("expression_position_of").select "否定的"
      fill_in "簡単にいうと(要点) :", with: "否定の表現を投稿"
      click_button "みんなに伝える"
      expect(page).to have_content "おめでとうございます"
      expect(page).to have_content "否定"
    end

    scenario "Signed_in_user create positive expresssion" do
      visit argument_path(@argument)
      find_by_id("expression_position_of").select "肯定的"
      fill_in "簡単にいうと(要点) :", with: "肯定の表現を投稿"
      click_button "みんなに伝える"
      expect(page).to have_content "おめでとうございます"
      expect(page).to have_content "肯定"
    end
  end

  describe "Flow around index" do
    let!(:expression) { create(:expression) }

    scenario "The user confirm expresssions page" do
      visit expressions_path
      expect(page).to have_content "プログラミング楽しい"
      expect(page).to have_content @expression.user.optional_id
    end

    scenario "Positive expression is only in positive box" do
      visit expressions_path
      expect(page).to have_selector '.positive-box', text: 'プログラミング楽しい'
      expect(page).not_to have_selector '.negative-box', text: 'プログラミング楽しい'
      expect(page).not_to have_selector '.neutral-box', text: 'プログラミング楽しい'
    end

    scenario "Neutaral expression is only in neutral box" do
      visit expressions_path
      expect(page).not_to have_selector '.positive-box', text: expression.statement
      expect(page).not_to have_selector '.negative-box', text: expression.statement
      expect(page).to have_selector '.neutral-box', text: expression.statement
    end

    scenario "Written by someone, is transition link to someone's page" do
      visit expressions_path
      click_link @expression.user.optional_id
      expect(page).to have_content @expression.user.name
      expect(page).to have_content "USER INFOMATION"
    end

    scenario "Argument topic click, only the argument's expression exsist" do
      visit expressions_path
      click_link @expression.argument.topic
      expect(page).to have_content @expression.argument.topic
      expect(page).to have_content "Argument is"
    end

    scenario "Getting limited argument, only the argument's expression exsist" do
      visit expressions_path
      expect(page).to have_content expression.statement
      click_button "GO"
      expect(page).to have_content @expression.argument.topic
      expect(page).to have_content "Argument is"
      expect(page).not_to have_content expression.statement
    end

    scenario "The user create expression's review" do
      visit expressions_path
      expect(page).to have_content 'NO YET REVIEW'
      click_link @expression.statement
      @expression.reviews.create(user_id: @user.id, rate: 5)
      visit expressions_path
      expect(page).to have_content 'REVIEW 平均 ★5'
    end
  end
end
