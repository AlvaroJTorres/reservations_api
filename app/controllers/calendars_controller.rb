# frozen_string_literal: true

# Controllers for Calendar Model
class CalendarsController < ApplicationController
  before_action -> { doorkeeper_authorize! :manager }

  def create
    result = Operations::CalendarOperations::Create.call(params: calendar_params,
                                                         restaurant_id: params[:restaurant_id])
    render json: { data: { calendar: result[:model] } }, status: :created
  end

  def update
    result = Operations::CalendarOperations::Update.call(params: calendar_params,
                                                         restaurant_id: params[:restaurant_id],
                                                         calendar_id: params[:id])
    render json: { data: { calendar: result[:model] } }
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
