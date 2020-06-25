require 'rails_helper'

RSpec.feature "Around event functions", type: :feature do
  include Devise::Test::IntegrationHelpers
  background do
    @user = create(:example_user)
  end

  xdescribe '#create' do
  end

  describe '#show' do
    context 'Existing event already' do
      let(:event){ create(:event) }
      scenario "Page has event's correct data" do
        visit event_path(event)
        expect(page).to have_content event.title
        expect(page).to have_content event.argument.topic
      end
    end
  end
end
