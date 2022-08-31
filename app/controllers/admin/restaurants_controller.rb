# frozen_string_literal: true

module Admin
  # Controllers for Restaurant Model
  class RestaurantsController < Admin::ApplicationController
    def create
      result = Operations::RestaurantOperations::Create.call(params: restaurant_params)
      render json: { data: result[:model] }, status: :created
    end

    def update
      result = Operations::RestaurantOperations::Update.call(params: restaurant_params, id: params[:id])
      render json: { data: result[:model] }
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
end
