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
      scenario "Component is correct infomation" do
        visit components_path
        expect(page).to have_content component.title
        expect(page).to have_content component.description
        expect(page).to have_link "USERを見る"
        expect(page).not_to have_link "編集"
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

      scenario "Kind_of search hit" do
        visit components_path
        expect(page).to have_content component.title
        select "性別", from: 'kind_of'
        click_button "GO"
        expect(page).to have_content component.title
        select "仕事", from: 'kind_of'
        click_button "GO"
        expect(page).not_to have_content component.title
      end
    end
  end
end
