# frozen_string_literal: true

FactoryBot.define do
  factory :office_hour do
    day { 1 }
    open { '15:00' }
    close { '20:00' }
    association :restaurant
  end
end
