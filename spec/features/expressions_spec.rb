require 'rails_helper'

RSpec.feature "Around expression functions", type: :feature do
  include Devise::Test::IntegrationHelpers

  background do
    @user = create(:user)
    @argument = create(:tag_argument)
    @expression = create(:positive_expression)
  end

  describe "#create by Signed_in_user " do
    before do
      sign_in @user
    end
    scenario "User create expresssion" do
      visit argument_path(@argument)
      fill_in "簡単にいうと(要点) :", with: "初めての投稿"
      click_button "みんなに伝える"
      expect(find('.notice')).to have_content "おめでとうございます"
      expect(page).to have_content "初めての投稿"
    end

    scenario "User cannot create enough info" do
      visit argument_path(@argument)
      fill_in "簡単にいうと(要点) :", with: ""
      click_button "みんなに伝える"
      expect(page).to have_content "要点を入力してください"
      fill_in "簡単にいうと(要点) :", with: "初"
      click_button "みんなに伝える"
      expect(page).to have_content "要点は5文字以上で入力してください"
    end

    scenario "User create negative expresssion" do
      visit argument_path(@argument)
      find_by_id("expression_position_of").select "否定的"
      fill_in "簡単にいうと(要点) :", with: "否定の表現を投稿"
      click_button "みんなに伝える"
      expect(page).to have_content "おめでとうございます"
      expect(page).to have_content "否定"
    end

    scenario "User create positive expresssion" do
      visit argument_path(@argument)
      find_by_id("expression_position_of").select "肯定的"
      fill_in "簡単にいうと(要点) :", with: "肯定の表現を投稿"
      click_button "みんなに伝える"
      expect(page).to have_content "おめでとうございます"
      expect(page).to have_content "肯定"
    end
  end

  describe "#index" do
    let!(:expression) { create(:expression) }
    let!(:negative_exp) { create(:negative_expression) }


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

    scenario "Negative expression is only in negative box" do
      visit expressions_path
      expect(page).not_to have_selector '.positive-box', text: negative_exp.statement
      expect(page).to have_selector '.negative-box', text: negative_exp.statement
      expect(page).not_to have_selector '.neutral-box', text: negative_exp.statement
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

    scenario "The review count increases" do
      visit expressions_path
      expect(page).to have_content 'NO YET REVIEW'
      @expression.reviews.create(user_id: @user.id, rate: 5)
      visit expressions_path
      expect(page).to have_content 'REVIEW 平均 ★5'
    end
  end
end
