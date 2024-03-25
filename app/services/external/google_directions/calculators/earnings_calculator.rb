# frozen_string_literal: true

module External
  module GoogleDirections
    module Calculators
      class EarningsCalculator
        BASE_RATE = 12.0
        MILE_RATE = 1.50
        MINUTE_RATE = 0.70

        attr_reader :distance, :duration

        def initialize(distance:, duration:)
          @distance = distance
          @duration = duration
        end

        def call
          (BASE_RATE + distance_earnings + duration_earnings).round(2)
        end

        private

        def distance_earnings
          distance <= 5 ? 0 : (distance - 5) * MILE_RATE
        end

        def duration_earnings
          duration <= 0.25 ? 0 : (duration - 0.25) * MINUTE_RATE
        end
      end
    end
  end
end
