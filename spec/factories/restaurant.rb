# frozen_string_literal: true

FactoryBot.define do
  factory :restaurant do
    sequence(:name) { |n| "name #{n}" }
    address { 'Factory address' }
  end
end
