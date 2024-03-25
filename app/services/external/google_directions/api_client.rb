# frozen_string_literal: true

require 'httparty'

module External
  module GoogleDirections
    class ApiClient
      include HTTParty

      attr_reader :api_key

      base_uri ENV['GOOGLE_DIRECTIONS_BASE_URI']
      default_timeout 10

      def initialize
        @api_key = Rails.application.credentials[:google_directions_api]
      end

      def get_directions(home:, start:, destination:)
        url = '/maps/api/directions/json'
        query = {
          destination: parsed_address(destination),
          origin: parsed_address(home),
          waypoints: "via #{parsed_address(start)}",
          key: api_key
        }
        response = self.class.get(url, query:, timeout: @default_timeout)
        handle_response(response)
      end

      private

      def handle_failure(response)
        message = "Failed to fetch directions: #{response['status']}"
        message += " - #{response['error_message']}" if response['error_message']
        Rails.logger.warn(message)
      rescue StandardError => e
        Rails.logger.error("Error fetching directions: #{e.message}")
      end

      def handle_response(response)
        return response.parsed_response if response['status'] == 'OK'

        handle_failure(response)
        nil
      end

      def parsed_address(address)
        address.gsub(/[,\s]+/, '+')
      end
    end
  end
end
