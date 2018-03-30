require 'rspec'

require File.join(__dir__, 'driver_activity_report')

RSpec.describe DriverActivityReport::Row do
  let(:from) { Time.now }
  let(:to) { from + 5 }

  subject(:row) { described_class.new(from, to, :driving) }

  describe '#time' do
    it 'returns the elapsed working time' do
      expect(row.time).to eq 5
    end
  end
end
