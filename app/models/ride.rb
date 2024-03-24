# frozen_string_literal: true

class Ride < ApplicationRecord
  belongs_to :driver, optional: true
end
