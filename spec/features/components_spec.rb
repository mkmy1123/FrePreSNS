require 'rails_helper'

RSpec.feature "Around components", type: :feature do
  include Devise::Test::IntegrationHelpers

  describe "#index" do
    background do
      @user = create(:user)
    end

    context "When component exists" do
      let!(:component) { create(:component) }
      let!(:user) { create(:user) }
      let(:tag_component) { create(:tag_component) }
      scenario "Component is correct infomation" do
        visit components_path
        expect(page).to have_content component.title
        expect(page).to have_content component.description
        expect(page).to have_link "USERを見る"
        expect(page).not_to have_link "編集"
      end

      scenario "Everybody has link to components's user" do
        visit components_path
        expect(page).to have_content component.title
        expect(page).not_to have_content tag_component.title
        click_link 'USERを見る'
        expect(current_path).to eq user_path(component.user)
      end

      scenario "Component's user has edit button" do
        @component = build(:component)
        @component.user_id = @user.id
        @component.save
        sign_in @user
        visit components_path
        click_on '編集'
        expect(current_path).to eq edit_component_path(@component)
      end

      scenario "Kind_of search hits" do
        visit components_path
        expect(page).to have_content component.title
        select "性別", from: 'kind_of'
        click_button "GO"
        expect(page).to have_content component.title
        select "仕事", from: 'kind_of'
        click_button "GO"
        expect(page).not_to have_content component.title
      end

      scenario "Tag search hits" do
        tag_component.save
        visit components_path
        expect(page).to have_content tag_component.title
        expect(page).to have_content component.title
        click_link 'そんなタグ'
        expect(page).not_to have_content component.title
        expect(page).to have_content tag_component.title
      end
    end
  end

  describe "#edit" do
    background do
      @user = create(:user)
      sign_in @user
      @component = build(:tag_component)
      @component.user_id = @user.id
      @component.save
    end

    context "When component exists" do
      scenario "Component's user update Title" do
        visit edit_component_path(@component)
        fill_in "タイトル :", with: "こんな人です"
        click_button '追加する'
        expect(page).to have_content "こんな人です"
        expect(page).not_to have_content @component.title
      end

      scenario "Component's user update Description" do
        visit edit_component_path(@component)
        fill_in "説明 :", with: "そうなんです。こんな人です！"
        click_button '追加する'
        expect(page).to have_content "そうなんです。こんな人です！"
        expect(page).not_to have_content @component.description
      end

      scenario "Component's user update Tag" do
        visit edit_component_path(@component)
        fill_in "タグ :", with: "こんなジャンル"
        click_button '追加する'
        expect(page).to have_content "こんなジャンル"
        expect(page).not_to have_content @component.tag_list
      end

      scenario "Component's user update Kind_of" do
        visit components_path
        expect(page).to have_content "KIND_OF\n性別"
        visit edit_component_path(@component)
        select "体質", from: 'component_kind_of'
        click_button '追加する'
        expect(page).to have_content "KIND_OF\n体質"
        expect(page).not_to have_content "KIND_OF\n性別"
      end

      scenario "NOT component's user refuse" do
        sign_out @user
        visit edit_component_path(@component)
        expect(current_path).to eq root_path
      end
    end
  end
end
