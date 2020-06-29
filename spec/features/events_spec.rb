require 'rails_helper'

RSpec.feature "Around event functions", type: :feature do
  include Devise::Test::IntegrationHelpers
  background do
    @user = create(:example_user)
  end

  describe "#create" do
    let!(:argument){ create(:argument) }

    context "Existing argument already" do
      before do
        sign_in @user
        visit argument_path(argument)
      end
      scenario "User create event" do
        fill_in "イベントタイトル", with: "新しいイベント"
        fill_in "開始時間", with: "2090/09/10 11:22"
        fill_in "終了時間", with: "2090/09/11 11:22"
        fill_in "event[description]", with: "新しいイベントです"
        click_on "イベントを主催する"
        expect(page).to have_content "Eventが作成できました！"
        expect(page).to have_content "新しいイベント"
        expect(page).to have_content "新しいイベントです"
      end

      scenario "User create with mistake event info" do
        fill_in "イベントタイトル", with: "新しいイベント"
        fill_in "開始時間", with: "2000/09/10 11:22"
        fill_in "終了時間", with: "2000/09/11 11:22"
        fill_in "event[description]", with: "新しいイベントです"
        click_on "イベントを主催する"
        expect(page).to have_content "過去の日付は使えません"
      end
    end
  end

  describe "#show" do
    let!(:event){ create(:event) }

    context "Existing event already" do
      before do
        visit event_path(event)
      end
      scenario "Page has event's correct data" do
        expect(page).to have_content event.title
        expect(page).to have_content event.argument.topic
      end

      scenario "Page has user's correct data" do
        expect(page).to have_content event.user.name
        click_on event.user.name
        expect(current_url).to have_content(event.user.optional_id)
        expect(page).to have_content event.user.name
      end

      scenario "Page hasn't participation button" do
        expect(page).not_to have_button '参加する'
        expect(page).to have_content 'ログイン後に使える機能です'
      end

      scenario "Page hasn't communication button" do
        expect(page).not_to have_button '送信'
        expect(page).to have_content 'ログイン後に使える機能です'
      end

      context "By logined event's user" do
        before do
          sign_in event.user
          visit event_path(event)
        end

        scenario "Page has event edit button" do
          expect(page).to have_link 'イベントの編集'
          click_on 'イベントの編集'
          expect(current_path).to eq(edit_event_path(event))
        end

        scenario "User click participation button" do
          click_on '参加する'
          expect(page).to have_content '現在参加表明しているのは1人です。'
          click_on '参加を取り消す'
          expect(page).to have_content '現在参加表明しているのは0人です。'
        end
      end

      context "By logined user" do
        before do
          sign_in @user
          visit event_path(event)
        end
        scenario "Page has partipation button" do
          expect(page).to have_link '参加する'
        end

        scenario "User click participation button" do
          click_on '参加する'
          expect(page).to have_content '現在参加表明しているのは1人です。'
          click_on '参加を取り消す'
          expect(page).to have_content '現在参加表明しているのは0人です。'
        end

        scenario "Other user confirm paticipations" do
          click_on '参加する'
          sign_in event.user
          expect(page).to have_content '現在参加表明しているのは1人です。'
          expect(page).to have_content @user.optional_id
        end
      end
    end
  end

  describe "#edit" do
    let!(:event){ create(:event) }
    context "Existing event already" do
      before do
        sign_in event.user
        visit edit_event_path(event)
      end
      scenario "Page has function to edit and delete" do
        expect(page).to have_content 'EDIT EVENT'
        expect(page).to have_content 'DELETE EVENT'
      end

      scenario "Other user cannot get edit page" do
        sign_in @user
        visit edit_event_path(event)
        expect(page).not_to have_content 'EDIT EVENT'
        expect(page).not_to have_content 'DELETE EVENT'
        expect(current_path).to eq(root_path)
      end

      scenario "User click event delete button" do
        click_on "イベントを中止する"
        expect(page).to have_content 'このイベントは中止が宣言されました...'
        expect(page).not_to have_button '参加する'
        expect(page).to have_content 'イベントが中止されたので参加できません'
      end

      scenario "User update event" do
        fill_in "イベントタイトル", with: "もっと新しいイベント"
        click_on "イベントを主催する"
        expect(page).to have_content "もっと新しいイベント"
        expect(page).not_to have_content event.title
      end

      scenario "User cannot update wrong event info" do
        fill_in "イベントタイトル", with: ""
        click_on "イベントを主催する"
        expect(page).to have_content event.description
        expect(page).to have_content "イベントタイトルを入力してください"
      end

    end
  end
end
