require 'spec_helper'

module DriverActivity
  RSpec.describe AddEventInteractor do
    let(:event_repository) { spy(:event_repository, create: true) }
    let(:interactor) { described_class.new(event_repository) }

    describe '#run' do
      context 'with an event payload' do
        let(:payload) do
          {
            company_id: 123,
            driver_id: 456,
            timestamp: "2018-03-30'T'12:33:11",
            latitude: 52.234234,
            longitude: 13.23324,
            accuracy: 12.0,
            speed: 123.45
          }
        end

        let(:event) do
          Event.new(
            company_id: 123,
            driver_id: 456,
            timestamp: Time.new(2018, 3, 30, 12, 33, 11),
            latitude: 52.234234,
            longitude: 13.23324,
            accuracy: 12.0,
            speed: 123.45
          )
        end

        it 'creates an event' do
          interactor.run(payload)
          expect(event_repository).to have_received(:create).with(event)
        end
      end
    end
  end
end
