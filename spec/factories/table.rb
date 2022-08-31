# frozen_string_literal: true

FactoryBot.define do
  factory :table do
    seats { 4 }
    sequence(:description) { |n| "table ##{n}" }
    association :restaurant
  end
end
