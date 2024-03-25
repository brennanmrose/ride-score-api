# frozen_string_literal: true

RSpec.describe External::GoogleDirections::RideDataManager do
  subject(:call) { described_class.new(ride: ride, driver: driver).call }

  let(:ride) { build_stubbed(:ride) }
  let(:driver) { build_stubbed(:driver) }
  let(:cache) { Rails.cache }
  let(:memory_store) { ActiveSupport::Cache.lookup_store(:memory_store) }
  let(:cache_key_name) { "driver_ride_data:#{driver.id}:#{ride.id}" }

  before do
    allow(Rails).to receive(:cache).and_return(memory_store)
    allow(cache).to receive(:write).and_call_original

    ride_data_compiler = instance_double(External::GoogleDirections::RideDataCompiler)
    allow(External::GoogleDirections::RideDataCompiler).to receive(:new).
      and_return(ride_data_compiler)
    allow(ride_data_compiler).to receive(:call).and_return(processed_data)
  end

  describe 'Constants' do
    it { expect(described_class::CACHE_EXPIRY).to eq(30.minutes) }
  end

  describe '#call' do
    context 'always' do
      it 'returns the cached ride data' do
        expect(call).to eq(cached_data)
      end
    end

    context 'when cached data exists' do
      before { allow(cache).to receive(:read).with(cache_key_name).and_return(cached_data) }

      it 'does not call the RideDataCompiler' do
        expect(External::GoogleDirections::RideDataCompiler).not_to have_received(:new)
        call
      end
    end

    context 'when cached data does not exist' do
      before { cache.clear }

      it 'calls the RideDataCompiler' do
        call
        expect(External::GoogleDirections::RideDataCompiler).to have_received(:new)
      end

      it 'caches the processed data' do
        call
        expect(cache).to have_received(:write).
          with(cache_key_name, processed_data.with_indifferent_access,
          expires_in: described_class::CACHE_EXPIRY)
      end
    end
  end

  private

  def processed_data
    {
      commute_distance: 0.8,
      commute_duration: 0.058611111111111114,
      ride_distance: 17.8,
      ride_duration: 0.5408333333333334,
      ride_earnings: 31.4,
      score: 52.381835032437436
    }
  end

  def cached_data
    {
      id: ride.id,
      start_address: ride.start_address,
      destination_address: ride.destination_address,
      driver_data: { driver_id: driver.id, driver_home_address: driver.home_address }
    }.merge(processed_data).with_indifferent_access
  end
end
