# frozen_string_literal: true

# Controllers for Office Hour Model
# class OfficeHoursController < ApplicationController
#   before_action -> { doorkeeper_authorize! :manager }

#   def create
#     result = Operations::OfficeHourOperations::Create.call(params: office_hour_params,
#                                                            restaurant_id: params[:restaurant_id])
#     render json: { data: { office_hour: result[:model] } }, status: :created
#   end

#   def update
#     result = Operations::OfficeHourOperations::Update.call(params: office_hour_params,
#                                                            restaurant_id: params[:restaurant_id],
#                                                            office_hour_id: params[:id])
#     render json: { data: { office_hour: result[:model] } }
#   end

#   def destroy
#     Operations::OfficeHourOperations::Delete.call(restaurant_id: params[:restaurant_id],
#                                                   office_hour_id: params[:id])
#     render body: nil, status: :no_content
#   end

#   private

#   def office_hour_params
#     params.require(:data).permit(:day, :open, :close)
#   end
# end
