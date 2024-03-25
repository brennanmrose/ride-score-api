# frozen_string_literal: true

class Driver < ApplicationRecord
  has_many :rides, dependent: :nullify

  validates :home_address, presence: true

  def available_rides
    Ride.without_driver.map do |ride|
      ride_data = External::GoogleDirections::RideDataManager.new(ride: ride, driver: self).call
      ride_data.presence
    end.compact
  end
end
