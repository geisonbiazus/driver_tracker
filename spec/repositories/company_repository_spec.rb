require 'rails_helper'

RSpec.describe CompanyRepository do
  let(:repository) { CompanyRepository.new }

  describe '#create' do
    let(:company) { DriverTracker::Company.new(field: [[0, 0], [0, 1]]) }
    let(:created_company) { repository.create(company) }

    it 'creates and returns company' do
      expect { created_company }.to change(Company, :count).by(1)
      expect(created_company.field).to eq company.field
      expect(created_company).to be_persisted
    end
  end

  describe '#find_by_id' do
    let!(:company) { create(:company) }

    it 'finds the company by the given id' do
      expect(repository.find_by_id(company.id)).to eq company
    end
  end
end
