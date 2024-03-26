# Ride Score API Rails Application

This Rails application provides an API endpoint for retrieving a paginated list of rides in
  descending score order for a given driver. It calculates the score of each ride in $ per hour
  based on the provided specifications.

### Installation

To run this application locally, follow these steps:

1. Clone this repository to your local machine.
2. Install Ruby if you haven't already. This application requires Ruby version 3+.
3. Ensure you have Rails installed. This application is built with Rails 7+. You can install Rails
by running `gem install rails`.
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

The response will be a JSON array containing a paginated list of rides in descending score order.
Each ride object will include the following attributes:

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

### Usage

#### Caching

In this sample application, a basic caching mechanism using the default memory store provided by
Rails is employed. This choice is made for simplicity and ease of setup. However, in a
production-level application, it is recommended to utilize a more robust caching mechanism such as
Redis.

If deploying this application to a production environment, consider replacing the memory store with
Redis for improved performance and scalability. 

#### Authentication

As this application is a demo, it does not include authentication functionality. In a real-world
scenario, authentication would be a crucial aspect to ensure the security and privacy of user data.
If deploying this application to production, it's essential to implement proper authentication
mechanisms to protect sensitive information and restrict access to only authorized users.

#### Error Handling

While this application provides basic error handling, more robust error handling should be
implemented to handle various edge cases and unexpected scenarios.

In a production-level application, it's essential to anticipate and handle errors gracefully to
provide a better user experience and ensure the stability and reliability of the application.

If developing this application further, consider implementing additional error handling mechanisms,
  such as:

- Proper validation of input parameters and request payloads to prevent invalid data from entering
  the system.
- Custom error responses with informative error messages to help users understand and resolve
  issues.
- Logging of errors and exceptions to track and diagnose problems in the application.
- Exception handling strategies to gracefully handle unexpected errors and prevent them from
  crashing the application.

Enhancing error handling capabilities improves the overall quality and robustness of the
application, making it more resilient to failures and user errors.

### Testing

RSpec tests are included to ensure the correctness of the application's functionality. To run the
tests, execute the following command:

```
  bundle exec rspec --format documentation
```

## Contributing

Contributions are welcome! Please feel free to submit issues or pull requests.

## License

This project is licensed under the [MIT License](LICENSE).

For any further assistance or inquiries, please contact the maintainers.

---

This README provides basic information on setting up, using, and contributing to the Ride Score API
Rails Application. For detailed API documentation, refer to the separate
[API Documentation](./api_documentation.md) file.
