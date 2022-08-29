# frozen_string_literal: true

# Controllers for Table Model
class TablesController < ApplicationController
  before_action -> { doorkeeper_authorize! :manager }, only: %i[create destroy]
  before_action -> { doorkeeper_authorize! :customer }, only: %i[index]

  def index
    result = Operations::TableOperations::Index.call(params: query_params, restaurant_id: params[:restaurant_id])
    render json: { data: { restaurants: result[:model] } }
  end

  def create
    result = Operations::TableOperations::Create.call(params: table_params, restaurant_id: params[:restaurant_id])
    render json: { data: { table: result[:model] } }, status: :created
  end

  def destroy
    Operations::TableOperations::Delete.call(restaurant_id: params[:restaurant_id], table_id: params[:id])
    render body: nil, status: :no_content
  end

  private

  def table_params
    params.require(:data).permit(:seats, :description, :datetime)
  end

  def query_params
    params.slice(:datetime)
  end
end
