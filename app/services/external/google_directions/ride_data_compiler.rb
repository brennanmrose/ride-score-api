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
        calculate_earnings if fetch_directions
        @ride_data
      end

      private

      def calculate_earnings
        ride_earnings = Calculators::EarningsCalculator.new(distance: @ride_data[:ride_distance],
          duration: @ride_data[:ride_duration]).call
        @ride_data[:ride_earnings] = ride_earnings
      end

      def fetch_directions
        response = DirectionsParser.new(home_address: driver.home_address,
          start_address: ride.start_address, destination_address: ride.destination_address).call
        @ride_data = response if response.present?
      end
    end
  end
end
