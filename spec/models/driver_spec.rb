# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Driver, type: :model do
  describe 'Associations' do
    it { is_expected.to have_many(:rides).dependent(:nullify) }
  end

  describe 'Validations' do
    it { is_expected.to validate_presence_of(:home_address) }
  end

  describe '#available_rides' do
    subject(:available_rides) { driver.available_rides }

    let!(:driver) { create(:driver) }
    let!(:rides) { create_list(:ride, 2) }
    let(:ride_data) { { ride_data: 'example' } }

    before do
      allow(Ride).to receive(:without_driver).and_return(rides)

      ride_data_manager_double = instance_double(External::GoogleDirections::RideDataManager)
      allow(External::GoogleDirections::RideDataManager).to receive(:new).
        and_return(ride_data_manager_double)
      allow(ride_data_manager_double).to receive(:call).and_return(ride_data)
    end

    context 'when rides are available' do
      context 'when ride data is present' do
        let(:ride_data) { { ride_data: 'example' } }

        it 'returns ride data for available rides' do
          expect(available_rides).to eq([{ ride_data: 'example' }, { ride_data: 'example' }])
        end
      end

      context 'when ride data is blank' do
        let(:ride_data) { {} }

        it 'skips the ride data' do
          expect(available_rides).to eq([])
        end
      end
    end

    context 'when no rides are available' do
      let(:rides) { [] }

      it 'returns an empty array' do
        expect(available_rides).to eq([])
      end
    end
  end
end
