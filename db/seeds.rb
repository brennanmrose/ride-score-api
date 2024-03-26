# frozen_string_literal: true

# Create drivers
Driver.create!(home_address: '6200 W 3rd St, Los Angeles, CA')
driver_with_ride = Driver.create!(home_address: '4650 W Olympic Blvd, Los Angeles, CA')

# Create rides
rides = [
  {
    start_address: '1206 Orange Grv Ave, Los Angeles, CA',
    destination_address: '4357 Wilshire Blvd, Los Angeles, CA'
  },
  {
    start_address: '156 S Soto St, Los Angeles, CA',
    destination_address: '305 N Breed St, Los Angeles, CA'
  },
  {
    start_address: '335 E 33rd St, Los Angeles, CA',
    destination_address: '345 E 51st St, Los Angeles, CA'
  },
  {
    start_address: '706 E 92nd St, Los Angeles, CA',
    destination_address: '1000 Vin Scully Ave, Los Angeles, CA'
  },
  {
    start_address: '436 S Boyle Ave, Los Angeles, CA',
    destination_address: '3425 1st St, Los Angeles, CA'
  },
  {
    start_address: '161 S Gardner St, Los Angeles, CA',
    destination_address: '250 S Rossmore Ave, Los Angeles, CA',
    driver: driver_with_ride
  }
]

rides.each { |ride_data| Ride.create!(ride_data) }
