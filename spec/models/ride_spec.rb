# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Ride, type: :model do
  describe 'Associations' do
    it { is_expected.to belong_to(:driver).optional }
  end

  describe 'Validations' do
    it { is_expected.to validate_presence_of(:start_address) }
    it { is_expected.to validate_presence_of(:destination_address) }
  end

  describe '.without_driver' do
    let!(:rides_without_driver) { create_list(:ride, 2) }
    let!(:ride_with_driver) { create(:ride, :with_driver) }

    it 'returns rides without a driver assigned' do
      expect(described_class.without_driver).to eq(rides_without_driver)
    end

    it 'does not return rides with a driver assigned' do
      expect(described_class.without_driver).not_to include(ride_with_driver)
    end
  end
end
