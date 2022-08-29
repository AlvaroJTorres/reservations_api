# frozen_string_literal: true

module Querys
  # Queries for Restaurant Model
  class RestaurantsQuery
    attr_reader :relation

    def initialize(relation = Restaurant.all)
      @relation = relation
    end

    def available_restaurants
      relation.where('deleted_at IS NULL')
    end
  end
end
