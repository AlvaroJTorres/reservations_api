# frozen_string_literal: true

module Operations
  module OfficeHourOperations
    # Operation to delete Office Hours on API
    class Delete < Trailblazer::Operation
      pass :find_restaurant
      pass :find_office_hour
      pass :delete_office_hour

      def find_restaurant(options, restaurant_id:, **)
        options[:restaurant] = Restaurant.find_by!(id: restaurant_id)
      end

      def find_office_hour(options, office_hour_id:, **)
        options[:model] = options[:restaurant].office_hours.find_by!(id: office_hour_id)
      end

      def delete_office_hour(options, **)
        options[:model].destroy
      end
    end
  end
end
