# Ride Score API Rails Application

This Rails application provides an API endpoint for retrieving a paginated list of rides in
  descending score order for a given driver. It calculates the score of each ride in $ per hour
  based on the provided specifications.

### Installation

To run this application locally, follow these steps:

1. Clone this repository to your local machine.
2. Install Ruby if you haven't already. This application requires Ruby version 3+.
3. Ensure you have Rails installed. This application is built with Rails 7+. You can install Rails by running `gem install rails`.
4. Install dependencies by running `bundle install`.
5. Set up the database by running `rails db:create` followed by `rails db:migrate`.
6. Seed the database with sample data: `rails db:seed`.
7. Start the Rails server with `rails server`.
8. The application should now be running locally.

### API Endpoint

To access the API endpoint for retrieving rides, make a GET request to the following URL:

```
  GET /api/rides
```

#### Parameters

- `driver_id` (required): The ID of the driver for whom rides are being fetched.
- `page` (optional): The page number for paginating the results.
- `per_page` (optional): The number of rides per page.

#### Response

The response will be a JSON array containing a paginated list of rides in descending score order. Each ride object will include the following attributes:

- `id`
- `start_address`
- `destination_address`
- `driver_data`
  - `driver_id`
  - `driver_home_address`
- `commute_distance`
- `commute_duration`
- `ride_distance`
- `ride_duration`
- `ride_earnings`
- `score`

For detailed API documentation, please refer to [API Documentation](./api_documentation.md).

### Testing

RSpec tests are included to ensure the correctness of the application's functionality. To run the tests, execute the following command:

```
  bundle exec rspec --format documentation
```

## Contributing

Contributions are welcome! Please feel free to submit issues or pull requests.

## License

This project is licensed under the [MIT License](LICENSE).

For any further assistance or inquiries, please contact the maintainers.

---

This README provides basic information on setting up, using, and contributing to the Ride Score API Rails Application. For detailed API documentation, refer to the separate [API Documentation](./api_documentation.md) file.
