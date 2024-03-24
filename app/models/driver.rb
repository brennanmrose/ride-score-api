# frozen_string_literal: true

class Driver < ApplicationRecord
  has_many :rides, dependent: :nullify

  validates :home_address, presence: true
end
