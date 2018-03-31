require 'spec_helper'

module DriverTracker
  RSpec.describe CompanyInteractor do
    let(:created_company) { Company.new(id: 1) }
    let(:company_repository) { spy(:company_repository, create: created_company) }
    let(:interactor) { described_class.new(company_repository) }

    describe 'create' do
      context 'with valid field polygon' do
        let(:field) { [[0.5, 0.5], [0, 5], [5, 5]] }
        let(:company) { Company.new(field: field) }
        let(:created_company) { Company.new(id: 1, field: field) }
        let(:result) { interactor.create(field: field) }

        it 'creates a new company' do
          result
          expect(company_repository).to have_received(:create).with(company)
        end

        it 'returns success and the created company' do
          expect(result[:status]).to eq :success
          expect(result[:company]).to eq created_company
        end
      end
    end

    context 'with invalid field polygon' do
      let(:invalid_polygons) do
        [
          nil,
          '',
          'asdas',
          8,
          [1],
          [[1, 2, 3]],
          [[1, 'asd']]
        ]
      end

      it 'returns error' do
        invalid_polygons.each do |polygon|
          result = interactor.create(field: polygon)
          expect(result[:status]).to eq :error
          expect(result[:errors]).to eq(
            [{ field: :field, type: described_class::INVALID }]
          )
        end
      end
    end
  end
end
