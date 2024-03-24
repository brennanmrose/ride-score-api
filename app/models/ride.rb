# frozen_string_literal: true

class Ride < ApplicationRecord
  belongs_to :driver, optional: true

  validates :start_address, :destination_address, presence: true
end
