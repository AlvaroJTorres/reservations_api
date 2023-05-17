# frozen_string_literal: true

module Operations
  module TableOperations
    # Operation to delete Tables on API
    class Delete < Trailblazer::Operation
      pass :find_restaurant
      pass :find_table
      step :delete_table

      def find_restaurant(options, restaurant_id:, **)
        raise CustomError.new(nil, 'Restaurant not found', 404, nil) unless options[:restaurant] = Restaurant.find_by!(id: restaurant_id)
      end

      def find_table(options, table_id:, **)
        raise CustomError.new(nil, 'Table not found', 404, nil) unless options[:model] = options[:restaurant].tables.find_by!(id: table_id)
      end

      def delete_table(options, **)
        options[:model].deleted_at = Time.now
        options[:model].save
      end
    end
  end
end
