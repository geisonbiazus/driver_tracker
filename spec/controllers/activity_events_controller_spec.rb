require 'rails_helper'

RSpec.describe ActivityEventsController, type: :controller do
  describe 'POST #create' do
    let(:event_params) do
      {
        company_id: '1',
        driver_id: '2',
        timestamp: '2018-03-30T12:33:11',
        latitude: '3',
        longitude: '4',
        accuracy: '4',
        speed: '6'
      }
    end
    let(:params) { { activity_event: event_params } }

    let(:create) { post :create, params: params }

    before do
      allow(AddActivityEventJob).to receive(:perform_later)
    end

    it 'enqueues an AddActivityEventJob' do
      create
      expect(AddActivityEventJob).to have_received(:perform_later)
        .with(event_params)
    end

    it 'returns http success' do
      create
      expect(response).to be_success
    end
  end
end
