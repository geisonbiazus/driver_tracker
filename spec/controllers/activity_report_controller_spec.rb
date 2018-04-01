require 'rails_helper'

RSpec.describe ActivityReportController, type: :controller do
  describe 'GET #index' do
    context 'with valid params' do
      let(:company) { create(:company) }
      let(:events) do
        [
          create(:activity_event, company: company, driver_id: 1),
          create(:activity_event, company: company, driver_id: 1),
          create(:activity_event, company: company, driver_id: 1)
        ]
      end

      it 'generates the report' do
        get :index, params: { driver_id: 1, date: Date.today }
        expect(response).to have_http_status(:success)
      end
    end

    context 'with invalid params' do
      it 'generates the report' do
        get :index, params: { }
        expect(response).to have_http_status(:bad_request)
      end
    end

    context 'with invalid date' do
      it 'generates the report' do
        get :index, params: { driver_id: 1, date: '2018-04-0' }
        expect(response).to have_http_status(:bad_request)
      end
    end
  end
end
