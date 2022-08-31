# frozen_string_literal: true

module Customer
  # Controllers for Table Model
  class TablesController < Customer::ApplicationController
    def index
      result = Operations::TableOperations::Index.call(params: query_params, restaurant_id: params[:restaurant_id])
      render json: { data: result[:model] }
    end

    private

    def table_params
      params.require(:data).permit(:datetime)
    end

    def query_params
      params.slice(:datetime)
    end
  end
end
