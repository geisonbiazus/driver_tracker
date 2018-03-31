require 'spec_helper'

RSpec.describe DriverTracker::Polygon do
  let(:points) { [[0, 0], [0, 5], [5, 5], [5, 0], [0, 0]] }
  subject(:polygon) { described_class.new(points) }

  describe '#contains?' do
    it 'checks if a point is inside the polygon' do
      expect(polygon.contains?([2, 2])).to be_truthy
      expect(polygon.contains?([2, 6])).to be_falsey
      expect(polygon.contains?([4, 4])).to be_truthy
      expect(polygon.contains?([6, 6])).to be_falsey
    end
  end
end
