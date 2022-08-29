# frozen_string_literal: true

class Table < ApplicationRecord
  belongs_to :restaurant
  has_many :reservations
end
