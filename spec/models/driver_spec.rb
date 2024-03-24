# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Driver, type: :model do
  it { is_expected.to have_many(:rides).dependent(:nullify) }
end
