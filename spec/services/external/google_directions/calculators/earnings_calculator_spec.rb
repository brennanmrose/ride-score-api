# frozen_string_literal: true

RSpec.describe External::GoogleDirections::Calculators::EarningsCalculator do
  subject(:call) { described_class.new(distance: distance, duration: duration).call }

  let(:distance) { 17.8 }
  let(:duration) { 0.5408333333333334 }

  describe 'Constants' do
    it { expect(described_class::BASE_RATE).to eq(12.0) }
    it { expect(described_class::MILE_RATE).to eq(1.50) }
    it { expect(described_class::MINUTE_RATE).to eq(0.70) }
  end

  describe '#call' do
    let(:base_rate) { described_class::BASE_RATE }
    let(:distance_rate) { (distance - 5) * described_class::MILE_RATE }
    let(:duration_rate) { (duration - 0.25) * described_class::MINUTE_RATE }

    context 'when distance is less than or equal to 5 miles' do
      let(:distance) { 4 }

      context 'when duration is less than or equal to 0.25 hours' do
        let(:duration) { 0.2 }

        it 'returns the base rate' do
          expect(call).to eq(base_rate)
        end
      end

      context 'when duration is greater than 0.25 hours' do
        let(:duration) { 0.75 }

        it 'adds a duration rate to the base rate and rounds to two' do
          expect(call).to eq((base_rate + duration_rate).round(2))
        end
      end
    end

    context 'when distance is greater than 5 miles' do
      let(:distance) { 10 }

      context 'when duration is less than or equal to 0.25 hours' do
        let(:duration) { 0.2 }

        it 'adds a distance rate to the base rate and rounds to two' do
          expect(call).to eq((base_rate + distance_rate).round(2))
        end
      end

      context 'when duration is greater than 0.25 hours' do
        let(:duration) { 0.75 }

        it 'adds a duration rate and a distance rate to the base rate and rounds to two' do
          expect(call).to eq((base_rate + duration_rate + distance_rate).round(2))
        end
      end
    end
  end
end
