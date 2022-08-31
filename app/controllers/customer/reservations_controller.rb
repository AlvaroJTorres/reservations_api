# frozen_string_literal: true

module Customer
  # Controllers for Reservation Model
  class ReservationsController < Customer::ApplicationController
    def create
      result = Operations::ReservationOperations::Create.call(params: reservation_params, user: current_user)
      render json: { data: result[:model] }, status: :created
    end

    private

    def reservation_params
      params.require(:data).permit(:table_id, :datetime)
    end
  end
end
