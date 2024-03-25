# frozen_string_literal: true

RSpec.describe External::GoogleDirections::Calculators::ScoreCalculator do
  subject(:call) do
    described_class.new(
      ride_earnings: ride_earnings,
      commute_duration: commute_duration,
      ride_duration: ride_duration
    ).call
  end

  let(:ride_earnings) { 31.4 }
  let(:commute_duration) { 0.058611111111111114 }
  let(:ride_duration) { 0.5408333333333334 }

  describe '#call' do
    it 'calculates the score correctly' do
      expect(call).to eq(ride_earnings / (commute_duration + ride_duration))
    end
  end
end
