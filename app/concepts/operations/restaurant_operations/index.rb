# frozen_string_literal: true

module Operations
  module RestaurantOperations
    # Operation to index Restaurants on API
    class Index < Trailblazer::Operation
      step :restaurant_list
      step :representer

      def restaurant_list(options, **)
        options[:model] = Querys::RestaurantsQuery.new.available_restaurants
      end

      def representer(options, model:, **)
        p options[:model]
        options[:model] = Representers::RestaurantRepresenter.for_collection.new(model)
      end
    end
  end
end
