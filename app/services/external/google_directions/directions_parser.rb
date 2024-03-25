# frozen_string_literal: true

module External
  module GoogleDirections
    class DirectionsParser
      attr_reader :home_address, :start_address, :destination_address, :direction_data

      def initialize(home_address:, start_address:, destination_address:)
        @home_address = home_address
        @start_address = start_address
        @destination_address = destination_address
        @direction_data = {}
      end

      def call
        parse_directions
        direction_data
      end

      private

      def directions
        ApiClient.new.get_directions(home: home_address, start: start_address, destination:
          destination_address)
      end

      def distance_in_miles(text)
        text.split(' ').first.to_f if text
      end

      def parse_commute(route_leg)
        direction_data[:commute_distance] = distance_in_miles(route_leg['distance']['text'])
        direction_data[:commute_duration] = route_leg['duration']['value'] / 3600.0
      end

      def parse_directions
        response = directions
        return unless response
        parse_commute(response['routes'].first['legs'].first)
        parse_ride(response['routes'].first['legs'].last)
      end

      def parse_ride(route_leg)
        direction_data[:ride_distance] = distance_in_miles(route_leg['distance']['text'])
        direction_data[:ride_duration] = route_leg['duration']['value'] / 3600.0
      end
    end
  end
end
