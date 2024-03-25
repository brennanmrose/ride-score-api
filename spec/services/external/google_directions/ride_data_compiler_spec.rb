# frozen_string_literal: true

RSpec.describe External::GoogleDirections::RideDataCompiler do
  subject(:call) { described_class.new(ride: ride, driver: driver).call }

  let(:ride) { build_stubbed(:ride) }
  let(:driver) { build_stubbed(:driver) }

  before do
    directions_parser = instance_double(External::GoogleDirections::DirectionsParser)
    allow(External::GoogleDirections::DirectionsParser).to receive(:new).
      with(home_address: driver.home_address, start_address: ride.start_address,
        destination_address: ride.destination_address).
      and_return(directions_parser)
    allow(directions_parser).to receive(:call).and_return(parsed_directions)
  end

  describe '#call' do
    context 'when the DirectionsParser returns parsed directions' do
      it 'returns the ride data' do
        expect(call).to eq(ride_data)
      end

      it 'includes the ride_earnings' do
        expect(call[:ride_earnings]).to be_present
      end
    end

    context 'when the DirectionsParser returns an empty hash' do
      let(:parsed_directions) { {} }

      it 'returns an empty hash' do
        expect(call).to eq({})
      end
    end
  end

  private

  def earnings_data
    { ride_earnings: 31.4 }
  end

  def parsed_directions
    {
      commute_distance: 0.8,
      commute_duration: 0.058611111111111114,
      ride_distance: 17.8,
      ride_duration: 0.5408333333333334
    }
  end

  def ride_data
    parsed_directions.merge(earnings_data)
  end
end
