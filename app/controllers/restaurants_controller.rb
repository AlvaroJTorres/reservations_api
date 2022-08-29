# frozen_string_literal: true

# Controllers for Restaurant Model
class RestaurantsController < ApplicationController
  before_action -> { doorkeeper_authorize! :admin }, only: %i[create update destroy]
  before_action -> { doorkeeper_authorize! :customer }, only: %i[index]

  def index
    result = Operations::RestaurantOperations::Index.call(params: {})
    render json: { data: { restaurants: result[:model] } }
  end

  def create
    result = Operations::RestaurantOperations::Create.call(params: restaurant_params)
    render json: { data: { restaurant: result[:model] } }, status: :created
  end

  def update
    result = Operations::RestaurantOperations::Update.call(params: restaurant_params, id: params[:id])
    render json: { data: { restaurant: result[:model] } }
  end

  def destroy
    Operations::RestaurantOperations::Delete.call(params: params[:id])
    render body: nil, status: :no_content
  end

  private

  def restaurant_params
    params.require(:data).permit(:name, :address, :user_id, images: [])
  end
end
