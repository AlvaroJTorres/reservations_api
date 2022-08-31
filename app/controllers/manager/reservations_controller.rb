# frozen_string_literal: true

module Manager
  # Controllers for Reservation Model
  class ReservationsController < ApplicationController
    def show
      result = Operations::ReservationOperations::Show.call(params: params[:customer_code])
      render json: { data: result[:model] }
    end

    def update
      result = Operations::ReservationOperations::Update.call(params: params[:customer_code])
      render json: { data: result[:model] }
    end

    def destroy
      Operations::ReservationOperations::Delete.call(params: params[:customer_code])
      render body: nil, status: :no_content
    end
  end
end
