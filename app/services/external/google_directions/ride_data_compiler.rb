# frozen_string_literal: true

module External
  module GoogleDirections
    class RideDataCompiler
      attr_reader :ride, :driver

      def initialize(ride:, driver:)
        @ride = ride
        @driver = driver
        @ride_data = {}
      end

      def call
        fetch_directions
        @ride_data
      end

      private

      def fetch_directions
        response = DirectionsParser.new(home_address: driver.home_address,
          start_address: ride.start_address, destination_address: ride.destination_address).call
        @ride_data = response if response.present?
      end
    end
  end
end
