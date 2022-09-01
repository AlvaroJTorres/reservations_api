# frozen_string_literal: true

module Operations
  module TableOperations
    # Operation to index Tables on API
    class Index < Trailblazer::Operation
      pass :find_restaurant
      pass :tables_list
      pass :pagy_custom

      def find_restaurant(options, restaurant_id:, **)
        options[:restaurant] = Restaurant.find_by!(id: restaurant_id)
      end

      def tables_list(options, params:, **)
        options[:model] = Querys::TablesQuery.new(options[:restaurant]).available_tables(params[:datetime])
      end

      def pagy_custom(options, **)
        options[:pagy], options[:records] = options[:pagy_call].call(options[:model], items: 10)
        options[:records] = Representers::TableRepresenter.for_collection.new(options[:records])
      end
    end
  end
end
