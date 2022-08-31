# frozen_string_literal: true

module Customer
  # Controllers for Restaurant Model
  class RestaurantsController < Customer::ApplicationController
    def index
      result = Operations::RestaurantOperations::Index.call(params: {})
      render json: { data: result[:model] }
    end
  end
end
