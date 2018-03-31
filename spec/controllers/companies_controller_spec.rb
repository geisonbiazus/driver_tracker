require 'rails_helper'

RSpec.describe CompaniesController, type: :controller do
  describe 'POST #create' do
    let(:create) { post :create, params: params }

    context 'with a valid params' do
      let(:params) { { company: { field: '[[0, 0], [0, 5], [5, 5]]' } } }

      it 'creates a new company' do
        expect { create }.to change(Company, :count).by(1)
      end

      it 'returns status created' do
        create
        expect(response).to be_created
      end

      it 'returns the created company' do
        create
        expect(response.body).to eq(
          { status: :success, company: Company.last }.to_json
        )
      end
    end

    context 'with invalid params' do
      let(:params) { { company: { field: 'invalid' } } }
      let(:error_response) do
        {
          status: 'error',
          errors: [{ field: 'field', type: 'INVALID' }]
        }
      end

      it 'returns status unprocessable' do
        create
        expect(response).to be_unprocessable
      end

      it 'returns the validation errors' do
        create
        expect(response.body).to eq error_response.to_json
      end
    end
  end
end
