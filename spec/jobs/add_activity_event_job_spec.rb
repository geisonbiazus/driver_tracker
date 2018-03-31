require 'rails_helper'

RSpec.describe AddActivityEventJob, type: :job do
  let(:job) { described_class.new }

  describe '#perform' do
    context 'with valid data' do
      let(:company) { create(:company) }

      let(:event_data) do
        {
          company_id: company.id.to_s,
          driver_id: '2',
          timestamp: '2018-03-30T12:33:11',
          latitude: '3',
          longitude: '4',
          accuracy: '4',
          speed: '6'
        }
      end

      let(:perform) { job.perform(event_data) }

      it 'creates an event' do
        expect { perform }.to change(ActivityEvent, :count).by(1)
      end
    end

    context 'with invalid data' do
      it 'does not break' do
        job.perform({})
      end
    end
  end
end
