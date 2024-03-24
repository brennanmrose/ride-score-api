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
end
