# frozen_string_literal: true

module Operations
  module TableOperations
    # Operation to index Tables on API
    class Index < Trailblazer::Operation
      pass :find_restaurant
      pass :tables_list
      pass :representer

      def find_restaurant(options, restaurant_id:, **)
        options[:restaurant] = Restaurant.find_by!(id: restaurant_id)
      end

      def tables_list(options, params:, **)
        options[:model] = Querys::TablesQuery.new(options[:restaurant]).available_tables(params[:datetime])
      end

      def representer(options, model:, **)
        options[:model] = Representers::TableRepresenter.for_collection.new(model)
      end
    end
  end
end
