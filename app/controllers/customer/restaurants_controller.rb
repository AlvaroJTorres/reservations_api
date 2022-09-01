# frozen_string_literal: true

module Customer
  # Controllers for Restaurant Model
  class RestaurantsController < Customer::ApplicationController
    def index
      result = Operations::RestaurantOperations::Index.call(params: {}, pagy_call: method(:pagy))
      render json: { data: result[:records] }.merge!(meta: { pagination: pagy_headers_hash(result[:pagy]) }),
             status: :ok
    end
  end
end
