require 'rails_helper'

RSpec.feature "Around users", type: :feature do
  include Devise::Test::IntegrationHelpers
  background do
    @user = create(:example_user)
  end

  describe '#index' do
    context '' do
    end
  end
end
