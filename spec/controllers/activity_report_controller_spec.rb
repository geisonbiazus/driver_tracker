require 'rails_helper'

RSpec.describe ActivityReportController, type: :controller do
  describe 'GET #index' do
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
end
