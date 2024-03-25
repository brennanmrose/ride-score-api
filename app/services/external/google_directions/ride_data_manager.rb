# frozen_string_literal: true

module External
  module GoogleDirections
    class RideDataManager
      CACHE_EXPIRY = 30.minutes

      attr_reader :ride, :driver

      def initialize(ride:, driver:)
        @ride = ride
        @driver = driver
      end

      def call
        process_ride_score if cached_data.nil?
        ride_data
      end

      private

      def cache_data(data)
        Rails.cache.write(cache_key_name, data.with_indifferent_access, expires_in: CACHE_EXPIRY)
      end

      def cache_key_name
        @cache_key_name ||= "driver_ride_data:#{driver.id}:#{ride.id}"
      end

      def cached_data
        Rails.cache.read(cache_key_name)
      end

      def data_from_records
        {
          'id' => ride.id,
          'start_address' => ride.start_address,
          'destination_address' => ride.destination_address,
          'driver_data' => driver_data
        }
      end

      def driver_data
        { 'driver_id' => driver.id, 'driver_home_address' => driver.home_address }
      end

      def process_ride_score
        response = RideDataCompiler.new(ride: ride, driver: driver).call
        cache_data(response)
      end

      def ride_data
        data_from_records.merge(cached_data)
      end
    end
  end
end
