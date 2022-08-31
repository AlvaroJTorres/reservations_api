# frozen_string_literal: true

# Controllers for Reservation Model
# class ReservationsController < ApplicationController
#   before_action -> { doorkeeper_authorize! :customer }, only: %i[create]
#   before_action -> { doorkeeper_authorize! :manager }, only: %i[show update destroy]

#   def show
#     result = Operations::ReservationOperations::Show.call(params: params[:customer_code])
#     render json: { data: { reservation: result[:model] } }
#   end

#   def create
#     result = Operations::ReservationOperations::Create.call(params: reservation_params, user: current_user)
#     render json: { data: { reservation: result[:model] } }, status: :created
#   end

#   def update
#     result = Operations::ReservationOperations::Update.call(params: params[:customer_code])
#     render json: { data: { reservation: result[:model] } }
#   end

#   def destroy
#     Operations::ReservationOperations::Delete.call(params: params[:customer_code])
#     render body: nil, status: :no_content
#   end

#   private

#   def reservation_params
#     params.require(:data).permit(:table_id, :datetime)
#   end
# end
