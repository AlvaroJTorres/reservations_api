# frozen_string_literal: true

module Operations
  module ReservationOperations
    # Operation to show Reservations on API
    class Delete < Trailblazer::Operation
      pass :find_reservation
      pass :delete_reservation

      def find_reservation(options, params:, **)
        options[:model] = Reservation.find_by!(customer_code: params)
      end

      def delete_reservation(options, **)
        options[:model].destroy
      end
    end
  end
end
