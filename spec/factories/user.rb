# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    name { 'Alvaro Torres' }
    sequence(:email) { |n| "Test#{n}@mail.com" }
    role { 0 }
  end
end
