require 'rspec'
require 'date'

require File.join(__dir__, 'tracking_event')
require File.join(__dir__, 'driver_activity_report')
require File.join(__dir__, 'driver_activity_report_interactor')

RSpec.describe DriverActivityReportInteractor do
  describe '#generate' do
    let(:tracking_event_repository) { double }
    let(:report) { described_class.new(tracking_event_repository) }
    let(:driver_id) { 1 }
    let(:date) { Date.today }
    let(:time) { Time.now }

    subject(:result) { report.generate(driver_id, date) }

    before do
      allow(tracking_event_repository)
        .to receive(:find_by_driver_id_and_date)
        .with(driver_id, date)
        .and_return(tracking_events)
    end

    context 'with one tracking event saved' do
      let(:tracking_events) do
        [TrackingEvent.new(timestamp: time, activity: :driving)]
      end

      let(:expected_result) do
        [
          DriverActivityReport::Row.new(time, time, :driving)
        ]
      end

      it 'returns a one line report' do
        expect(result.driver_id).to eq driver_id
        expect(result.date).to eq date
        expect(result.rows).to eq expected_result
      end
    end

    context 'with two events with the same activity' do
      let(:from_time) { time }
      let(:to_time) { time + 5 * 60 }

      let(:tracking_events) do
        [
          TrackingEvent.new(timestamp: from_time, activity: :driving),
          TrackingEvent.new(timestamp: to_time, activity: :driving)
        ]
      end

      let(:expected_result) do
        [
          DriverActivityReport::Row.new(from_time, to_time, :driving)
        ]
      end

      it 'returns a one line report with from and to set' do
        expect(result.rows).to eq expected_result
      end
    end
  end
end
