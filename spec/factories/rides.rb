# frozen_string_literal: true

FactoryBot.define do
  factory :ride do
    start_address { '616 Masselin Ave, Los Angeles, CA' }
    destination_address { '905 E El Segundo Blvd, Los Angeles, CA' }

    trait :with_driver do
      association :driver
    end
  end
end
