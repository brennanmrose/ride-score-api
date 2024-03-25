# API Documentation

## Get Available Rides

### Request

`GET /api/rides`

### Parameters

| Name       | Type   | Description                |
|------------|--------|----------------------------|
| driver_id  | int    | The ID of the driver.      |
| page       | int    | Page number for pagination.|
| per_page   | int    | Number of rides per page.  |

### Response

- `id`: Unique identifier of the ride.
- `start_address`: The starting address of the ride.
- `destination_address`: The destination address of the ride.
- `driver_data`: Includes the unique `driver_id` and `driver_home_address` which is the starting point of the commute.
- `commute_distance`: The driving distance from the driver's home address to the start of the ride, in miles.
- `commute_duration`: The expected time it takes to drive the commute distance, in hours.
- `ride_distance`: The driving distance from the start address of the ride to the destination address, in miles.
- `ride_duration`: The expected time it takes to drive the ride distance, in hours.
- `ride_earnings`: The earnings of the ride, considering time and distance.
- `score`: The score of the ride in $ per hour.


- **200 OK** on success:

  ```json
  [
    {
      "id": 15,
      "start_address": "616 Masselin Ave, Los Angeles, CA",
      "destination_address": "905 E El Segundo Blvd, Los Angeles, CA",
      "driver_data": {
        "driver_id": 1,
        "driver_home_address": "6200 W 3rd St, Los Angeles, CA"
      },
      "commute_distance": 0.8,
      "commute_duration": 0.058611111111111114,
      "ride_distance": 17.8,
      "ride_duration": 0.5408333333333334,
      "ride_earnings": 31.4,
      "score": 52.381835032437436
    },
    {
      "id": 16,
      "start_address": "2800 E Observatory Rd, Los Angeles, CA",
      "destination_address": "634 S Spring St #910, Los Angeles, CA",
      "driver_data": {
        "driver_id": 1,
        "driver_home_address": "6200 W 3rd St, Los Angeles, CA"
      },
      "commute_distance": 8.2,
      "commute_duration": 0.5011111111111111,
      "ride_distance": 9.8,
      "ride_duration": 0.41555555555555557,
      "ride_earnings": 19.32,
      "score": 21.076363636363638
    },
    {
      "id": 17,
      "start_address": "100 N Toluca St, Los Angeles, CA",
      "destination_address": "3575 Wilshire Blvd, Los Angeles, CA",
      "driver_data": {
        "driver_id": 1,
        "driver_home_address": "6200 W 3rd St, Los Angeles, CA"
      },
      "commute_distance": 6,
      "commute_duration": 0.38555555555555554,
      "ride_distance": 3.5,
      "ride_duration": 0.2436111111111111,
      "ride_earnings": 12,
      "score": 19.072847682119207
    }
  ]

- **404 NOT FOUND**:

  ```json
  {
    "error": "Driver not found"
  }

### Calculation of Ride Score

The score of a ride is calculated in $ per hour as follows:
```
  Ride Earnings / (Commute Duration + Ride Duration)
```

### Notes

- Google Maps API is used to calculate distances and durations. To reduce duplicate API calls, caching mechanisms are be implemented.
- Pagination allows fetching a subset of rides at a time, improving performance for large datasets.
- RSpec tests are included to ensure the correctness of the endpoint and associated logic.
- For any further assistance or inquiries, please contact the API maintainers.
