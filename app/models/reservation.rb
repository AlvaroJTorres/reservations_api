# frozen_string_literal: true

class Reservation < ApplicationRecord
  belongs_to :table

  enum status: { available: 0, reserved: 1, occupied: 2 }
end
