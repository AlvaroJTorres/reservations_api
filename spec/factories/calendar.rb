# frozen_string_literal: true

FactoryBot.define do
  factory :calendar do
    date { '31/08/2022' }
    reason { 'closed' }
    association :restaurant
  end
end
