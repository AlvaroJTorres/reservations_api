# frozen_string_literal: true

module Manager
  # Controllers for Office Hour Model
  class OfficeHoursController < Manager::ApplicationController
    def create
      result = Operations::OfficeHourOperations::Create.call(params: office_hour_params,
                                                             restaurant_id: params[:restaurant_id])
      render json: { data: result[:model] }, status: :created
    end

    def update
      result = Operations::OfficeHourOperations::Update.call(params: office_hour_params,
                                                             restaurant_id: params[:restaurant_id],
                                                             office_hour_id: params[:id])
      render json: { data: result[:model] }
    end

    def destroy
      Operations::OfficeHourOperations::Delete.call(restaurant_id: params[:restaurant_id],
                                                    office_hour_id: params[:id])
      render body: nil, status: :no_content
    end

    private

    def office_hour_params
      params.require(:data).permit(:day, :open, :close)
    end
  end
end
