require 'rails_helper'

RSpec.describe HomeController, type: :controller do
  describe "#top" do
    it "responds successfully" do
      get :top
      expect(response).to be_success
    end
  end
end
