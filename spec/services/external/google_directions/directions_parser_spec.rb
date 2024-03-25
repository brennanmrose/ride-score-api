# frozen_string_literal: true

require 'rails_helper'

RSpec.describe External::GoogleDirections::DirectionsParser do
  subject(:call) do
    described_class.new(
      home_address: home_address,
      start_address: start_address,
      destination_address: destination_address
    ).call
  end

  let(:ride) { build_stubbed(:ride) }
  let(:start_address) { ride.start_address }
  let(:destination_address) { ride.destination_address }

  let(:driver) { build_stubbed(:driver) }
  let(:home_address) { driver.home_address }

  before do
    api_client = instance_double(External::GoogleDirections::ApiClient)
    allow(External::GoogleDirections::ApiClient).to receive(:new).and_return(api_client)
    allow(api_client).to receive(:get_directions).
      with(home: home_address, start: start_address, destination: destination_address).
      and_return(api_response)
  end

  describe '#call' do
    context 'when the ApiClient returns directions' do
      let(:api_response) { JSON.parse(response_body) }

      it 'parses the directions' do
        expect(call).to eq(parsed_directions)
      end
    end

    context 'when the ApiClient returns nil' do
      let(:api_response) { nil }

      it 'returns an empty hash' do
        expect(call).to eq({})
      end
    end
  end

  private

  def parsed_directions
    {
      commute_distance: 0.8,
      commute_duration: 0.058611111111111114,
      ride_distance: 17.8,
      ride_duration: 0.5408333333333334
    }
  end

  def response_body
    {
      'routes' => [
        {
          'legs' => [
            {
              'distance' => { 'text' => '0.8 mi', 'value' => 1298 },
              'duration' => { 'text' => '4 mins', 'value' => 211 },
              'end_address' => "#{start_address} USA",
              'start_address' => "#{home_address} USA"
            },
            {
              'distance' => { 'text' => '17.8 mi', 'value' => 28_647 },
              'duration' => { 'text' => '32 mins', 'value' => 1947 },
              'end_address' => "#{destination_address} USA",
              'start_address' => "#{start_address} USA"
            }
          ]
        }
      ],
      'status' => 'OK'
    }.to_json
  end
end
