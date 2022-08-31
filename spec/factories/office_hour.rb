# frozen_string_literal: true

FactoryBot.define do
  factory :office_hour do
    day { 'monday' }
    open { '15:00' }
    close { '20:00' }
    association :restaurant
  end
end
