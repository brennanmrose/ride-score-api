# frozen_string_literal: true

module External
  module GoogleDirections
    module Calculators
      class ScoreCalculator
        attr_reader :ride_earnings, :commute_duration, :ride_duration

        def initialize(ride_earnings:, commute_duration:, ride_duration:)
          @ride_earnings = ride_earnings
          @commute_duration = commute_duration
          @ride_duration = ride_duration
        end

        def call
          ride_earnings / (commute_duration + ride_duration)
        end
      end
    end
  end
end
