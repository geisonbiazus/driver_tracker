require 'spec_helper'

RSpec.describe DriverActivity::Report::Row do
  let(:from) { Time.now }
  let(:to) { from + 5 }

  subject(:row) { described_class.new(from, to, :driving) }

  describe '#time' do
    it 'returns the elapsed working time' do
      expect(row.time).to eq 5
    end
  end
end
