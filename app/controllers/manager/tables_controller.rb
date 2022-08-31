# frozen_string_literal: true

module Manager
  # Controllers for Table Model
  class TablesController < Manager::ApplicationController
    def create
      result = Operations::TableOperations::Create.call(params: table_params, restaurant_id: params[:restaurant_id])
      render json: { data: result[:model] }, status: :created
    end

    def destroy
      Operations::TableOperations::Delete.call(restaurant_id: params[:restaurant_id], table_id: params[:id])
      render body: nil, status: :no_content
    end

    private

    def table_params
      params.require(:data).permit(:seats, :description)
    end
  end
end
