# frozen_string_literal: true

# Active job to cancel a reservation
class ReservationCancelationJob < ApplicationJob
  queue_as :default

  def perform(reservation)
    return unless model.status == 'reserved'

    reservation.status = 0
    reservation.save
  end
end
