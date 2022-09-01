# frozen_string_literal: true

module Operations
  module RestaurantOperations
    # Operation to index Restaurants on API
    class Index < Trailblazer::Operation
      step :restaurant_list
      step :pagy_custom

      def restaurant_list(options, **)
        options[:model] = Querys::RestaurantsQuery.new.available_restaurants
      end

      def pagy_custom(options, **)
        options[:pagy], options[:records] = options[:pagy_call].call(options[:model], items: 10)
        options[:records] = Representers::RestaurantRepresenter.for_collection.new(options[:records])
      end
    end
  end
end
