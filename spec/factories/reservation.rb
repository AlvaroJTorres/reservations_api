# frozen_string_literal: true

FactoryBot.define do
  factory :reservation do
    table
    datetime { '29/08/2022-20:00' }
    customer_code { '12345' }
    status { 'reserved' }
  end
end
