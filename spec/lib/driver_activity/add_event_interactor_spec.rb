require 'spec_helper'

module DriverActivity
  RSpec.describe AddEventInteractor do
    let(:company_repository) { spy(:company_repository) }
    let(:event_repository) { spy(:event_repository, create: true) }
    let(:interactor) { described_class.new(company_repository, event_repository) }

    describe '#run' do
      context 'with an invalid payload' do
        let(:payload) { {} }
        let(:result) { interactor.run(payload) }
        let(:errors) { result[:errors] }

        it 'returns status error' do
          expect(result[:status]).to eq :error
        end

        it 'validates the presence of each required attribute' do
          required = described_class::REQUIRED
          expect(errors).to include(field: :company_id, type: required)
          expect(errors).to include(field: :driver_id, type: required)
          expect(errors).to include(field: :timestamp, type: required)
          expect(errors).to include(field: :latitude, type: required)
          expect(errors).to include(field: :longitude, type: required)
          expect(errors).to include(field: :accuracy, type: required)
          expect(errors).to include(field: :speed, type: required)
        end
      end

      context 'with an event payload' do
        let(:company) do
          Company.new(
            id: 1,
            field: [[0, 0], [0, 5], [5, 5], [5, 0], [0, 0]]
          )
        end

        let(:latitude) { 2 }
        let(:longitude) { 2 }
        let(:speed) { 6 }
        let(:activity) { Event::CULTIVATING }

        let(:payload) do
          {
            company_id: company.id,
            driver_id: 2,
            timestamp: "2018-03-30'T'12:33:11",
            latitude: latitude,
            longitude: longitude,
            accuracy: 12.0,
            speed: speed
          }
        end

        let(:event) do
          Event.new(
            company_id: company.id,
            driver_id: 2,
            timestamp: Time.new(2018, 3, 30, 12, 33, 11),
            latitude: latitude,
            longitude: longitude,
            accuracy: 12.0,
            speed: speed,
            activity: activity
          )
        end

        before do
          allow(company_repository).to receive(:find_by_id)
            .with(company.id).and_return(company)
        end

        it 'creates an event' do
          interactor.run(payload)
          expect(event_repository).to have_received(:create).with(event)
        end

        it 'returns success status' do
          expect(interactor.run(payload)).to eq(status: :success)
        end

        context 'with an existing company' do
          context 'when event position is inside company field' do
            let(:latitude) { 2 }
            let(:longitude) { 2 }

            context 'when speed is greater than or equal to 1' do
              let(:speed) { 1 }
              let(:activity) { Event::CULTIVATING }

              it 'saves event activity as cultivating' do
                interactor.run(payload)
                expect(event_repository).to have_received(:create).with(event)
              end
            end

            context 'when speed is less than 1' do
              let(:speed) { 0.9 }
              let(:activity) { Event::REPAIRING }

              it 'saves event activity as repairing' do
                interactor.run(payload)
                expect(event_repository).to have_received(:create).with(event)
              end
            end
          end
          context 'when event position is inside company field' do
            let(:latitude) { 6 }
            let(:longitude) { 6 }

            context 'when speed is greater than or equal to 5' do
              let(:speed) { 5 }
              let(:activity) { Event::DRIVING }

              it 'saves event activity as driving' do
                interactor.run(payload)
                expect(event_repository).to have_received(:create).with(event)
              end
            end

            context 'when speed is less than 5' do
              let(:speed) { 4.9 }
              let(:activity) { Event::STOPPED }

              it 'saves event activity as stopped' do
                interactor.run(payload)
                expect(event_repository).to have_received(:create).with(event)
              end
            end
          end
        end
      end
    end
  end
end
