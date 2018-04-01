require 'rails_helper'

RSpec.describe ActivityReportHelper, type: :helper do
  describe '#presentable_time' do
    context 'with full hour' do
      it 'returns in the 3h format' do
        expect(helper.presentable_time(60.minutes.to_i)).to eq '1h'
        expect(helper.presentable_time(120.minutes.to_i)).to eq '2h'
        expect(helper.presentable_time(180.minutes.to_i)).to eq '3h'
      end

      it 'ignores seconds' do
        expect(helper.presentable_time(180.minutes.to_i + 20)).to eq '3h'
      end
    end

    context 'with broken hour' do
      it 'returns in the 3:42 format' do
        expect(helper.presentable_time(42.minutes.to_i)).to eq '0:42'
        expect(helper.presentable_time(119.minutes.to_i)).to eq '1:59'
        expect(helper.presentable_time(215.minutes.to_i)).to eq '3:35'
        expect(helper.presentable_time(60)).to eq '0:01'
      end

      it 'ignores seconds' do
        expect(helper.presentable_time(215.minutes.to_i + 20)).to eq '3:35'
      end
    end
  end
end
