require 'rails_helper'

RSpec.describe ActivityEventRepository do
  let(:repository) { described_class.new }

  describe '#create' do
    let!(:company) { create(:company) }
    let(:event) do
      DriverTracker::Activity::Event.new(
        company_id: company.id,
        driver_id: 2,
        timestamp: Time.now,
        latitude: 3,
        longitude: 4,
        accuracy: 5,
        speed: 6,
        activity: DriverTracker::Activity::Event::DRIVING
      )
    end
    let(:created_event) { repository.create(event) }

    it 'creates the event' do
      expect { created_event }.to change(ActivityEvent, :count).by(1)
      expect(created_event.company_id).to eq event.company_id
      expect(created_event.driver_id).to eq event.driver_id
      expect(created_event.timestamp).to eq event.timestamp
      expect(created_event.latitude).to eq event.latitude
      expect(created_event.longitude).to eq event.longitude
      expect(created_event.accuracy).to eq event.accuracy
      expect(created_event.activity).to eq event.activity
    end
  end

  describe '#find_all_by_driver_id_and_date_sorted_by_timestamp' do
    let!(:company) { create(:company) }
    let(:base_time) { Time.new(2018, 3, 31, 13, 31) }

    let!(:event_1) { create(:activity_event, company: company, driver_id: 1, timestamp: base_time - 1.day) }
    let!(:event_2) { create(:activity_event, company: company, driver_id: 1, timestamp: base_time) }
    let!(:event_3) { create(:activity_event, company: company, driver_id: 1, timestamp: base_time + 5.minutes) }
    let!(:event_4) { create(:activity_event, company: company, driver_id: 1, timestamp: base_time - 5.minutes) }
    let!(:event_5) { create(:activity_event, company: company, driver_id: 2, timestamp: base_time) }

    let(:expected_sorted_events) { [event_4, event_2, event_3] }

    it 'finds all events based on driver_id and date' do
      expect(repository.find_all_by_driver_id_and_date_sorted_by_timestamp(
               1, Date.today
      )).to eq expected_sorted_events
    end
  end
end
