# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Driver, type: :model do
  describe 'Associations' do
    it { is_expected.to have_many(:rides).dependent(:nullify) }
  end

  describe 'Validations' do
    it { is_expected.to validate_presence_of(:home_address) }
  end
end
