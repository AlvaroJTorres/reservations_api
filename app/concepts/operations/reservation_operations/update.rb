# frozen_string_literal: true

module Operations
  module ReservationOperations
    # Operation to show Reservations on API
    class Update < Trailblazer::Operation
      pass :find_reservation
      pass :update_reservation
      pass :representer

      def find_reservation(options, params:, **)
        options[:model] = Reservation.find_by!(customer_code: params)
      end

      def update_reservation(options, **)
        options[:model].status = 2
        options[:model].save!
      end

      def representer(options, model:, **)
        options[:model] = Representers::ReservationRepresenter.new(model)
      end
    end
  end
end
