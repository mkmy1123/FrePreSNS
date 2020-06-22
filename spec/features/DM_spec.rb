require 'rails_helper'

RSpec.feature "DM function", type: :feature do
  include Devise::Test::IntegrationHelpers

  background do
    @user = create(:user)
    @other_user = create(:user)
    @user.trust(@other_user)
    @other_user.trust(@user)
    sign_in @user
  end

  describe "Trusting user each other" do
    let(:room) { create(:room) }

    scenario "User send DM" do
      visit user_path(@other_user)
      click_button 'DMを送る'
      expect(page).to have_content "Direct Message"
      fill_in 'メッセージを入力して下さい', with: '初めてのDMです！'
      click_on '送信'
      expect(page).to have_content '初めてのDMです！'
      expect(page).to have_content @user.optional_id
    end

    scenario "User untrust, page don't be DM button" do
      @user.untrust(@other_user)
      visit user_path(@other_user)
      expect(page).not_to have_content 'DMを送る'
      click_link 'LOG OUT'
      sign_in @other_user
      visit user_path(@user)
      expect(page).not_to have_content 'DMを送る'
    end

    scenario "User send DM again" do
      @user.entries.create(room_id: room.id)
      @other_user.entries.create(room_id: room.id)
      @user.messages.create(room_id: room.id, content: '初めてのDM')
      visit user_path(@other_user)
      click_on 'DMを確認'
      expect(page).to have_content '初めてのDM'
      expect(page).to have_content @user.optional_id
    end

    scenario "User untrust, page don't be confirm DM button" do
      @user.entries.create(room_id: room.id)
      @other_user.entries.create(room_id: room.id)
      @user.messages.create(room_id: room.id, content: '初めてのDM')
      @user.untrust(@other_user)
      visit user_path(@other_user)
      expect(page).not_to have_content 'DMを確認'
    end
  end
end
