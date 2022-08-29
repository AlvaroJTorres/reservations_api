# frozen_string_literal: true

module Operations
  module ReservationOperations
    # Operation to show Reservations on API
    class Show < Trailblazer::Operation
      pass :find_reservation
      pass :representer

      def find_reservation(options, params:, **)
        options[:model] = Reservation.find_by!(customer_code: params)
      end

      def representer(options, model:, **)
        options[:model] = Representers::ReservationRepresenter.new(model)
      end
    end
  end
end
