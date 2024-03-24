# frozen_string_literal: true

class Driver < ApplicationRecord
  has_many :rides, dependent: :nullify
end
