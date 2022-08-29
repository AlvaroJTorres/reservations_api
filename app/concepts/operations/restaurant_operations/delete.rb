# frozen_string_literal: true

module Operations
  module RestaurantOperations
    # Operation to delete Restaurants on API
    class Delete < Trailblazer::Operation
      pass :find_restaurant
      step :delete_restaurant

      def find_restaurant(options, params:, **)
        options[:model] = Restaurant.find_by(id: params)
      end

      def delete_restaurant(options, **)
        options[:model].deleted_at = Time.now
        options[:model].save
      end
    end
  end
end
