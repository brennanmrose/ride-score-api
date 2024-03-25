# frozen_string_literal: true

require 'webmock/rspec'

RSpec.describe External::GoogleDirections::ApiClient do
  subject(:get_directions) do
    described_class.new.get_directions(
      home: home_address,
      start: start_address,
      destination: destination_address
    )
  end

  let(:ride) { build_stubbed(:ride) }
  let(:start_address) { ride.start_address }
  let(:destination_address) { ride.destination_address }

  let(:driver) { build_stubbed(:driver) }
  let(:home_address) { driver.home_address }

  let(:status) { 'OK' }

  before do
    allow(Rails.logger).to receive(:warn)
    allow(Rails.application.credentials).to receive(:[]).with(:google_directions_api).
      and_return('API_KEY')

    stub_request(:get, request_stub_url).with(headers: request_stub_headers).
      to_return(status:, body: response_body, headers: { 'Content-Type' => 'application/json' })
  end

  describe '#get_directions' do
    context 'when the request is successful' do
      let(:status) { 'OK' }

      it 'returns the response body' do
        expect(get_directions).to eq(JSON.parse(response_body))
      end
    end

    context 'when the request is unsuccessful' do
      context 'when the directions are not found' do
        let(:status) { 'NOT_FOUND' }

        it 'returns an error message' do
          get_directions
          expect(Rails.logger).to have_received(:warn).with(/Failed to fetch directions/)
        end
      end

      context 'when an unexpected error occurs' do
        before do
          stub_request(:get, request_stub_url).with(headers: request_stub_headers).
            to_raise(StandardError.new('Internal server error'))
        end

        it 'raises the error' do
          expect do
            get_directions
          end.to raise_error(StandardError)
        end
      end
    end
  end

  private

  def parsed_address(address)
    address.gsub(/[,\s]+/, '+')
  end

  def request_stub_headers
    {
      'Accept' => '*/*',
      'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
      'User-Agent' => 'Ruby'
    }
  end

  def request_stub_url
    'https://maps.googleapis.com/maps/api/directions/json?destination=4650%2BW%2BOlympic%2BBlvd%' \
      '2BLos%2BAngeles%2BCA&key=API_KEY&origin=6200%2BW%2B3rd%2BSt%2BLos%2BAngeles%2BCA%2B90036&' \
      'waypoints=via%20616%2BMasselin%2BAve%2BLos%2BAngeles%2BCA'
  end

  def response_body
    {
      'routes' => [
        {
          'legs' => [
            {
              'distance' => { 'text' => '2.3 mi', 'value' => 3679 },
              'duration' => { 'text' => '6 mins', 'value' => 350 },
              'end_address' => "#{start_address} USA",
              'start_address' => "#{home_address} USA"
            },
            {
              'distance' => { 'text' => '1.3 mi', 'value' => 2113 },
              'duration' => { 'text' => '4 mins', 'value' => 233 },
              'end_address' => "#{destination_address} USA",
              'start_address' => "#{start_address} USA"
            }
          ]
        }
      ],
      'status' => status
    }.to_json
  end
end
