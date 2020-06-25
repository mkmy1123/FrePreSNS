require 'rails_helper'

RSpec.feature "EventsController", type: :request do
  describe 'GET #index' do

    it 'responds ok' do
      get events_path
      expect(response.status).to eq 200
    end

    context 'Existing event already' do
      let(:headers) do
        { 'Content-Type' => 'application/json', 'Accept' => 'application/json' }
      end

      before do
        create(:event)
      end

      it 'has correct infomations' do
        get events_path, headers: headers
        expect(response.body).to include "楽しいイベント"
        expect(response.body).to include "楽しすぎるのできたほうがいいです"
      end

    end
  end
end