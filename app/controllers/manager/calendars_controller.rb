# frozen_string_literal: true

module Manager
  # Controllers for Calendar Model
  class CalendarsController < Manager::ApplicationController
    def create
      result = Operations::CalendarOperations::Create.call(params: calendar_params,
                                                           restaurant_id: params[:restaurant_id])
      render json: { data: result[:model] }, status: :created
    end

    def update
      result = Operations::CalendarOperations::Update.call(params: calendar_params,
                                                           restaurant_id: params[:restaurant_id],
                                                           calendar_id: params[:id])
      render json: { data: result[:model] }
    end

    def destroy
      Operations::CalendarOperations::Delete.call(restaurant_id: params[:restaurant_id], calendar_id: params[:id])
      render body: nil, status: :no_content
    end

    private

    def calendar_params
      params.require(:data).permit(:date, :reason)
    end
  end
end
