# frozen_string_literal: true

module Representers
  # Representable decorator for User JSON
  class TableRepresenter < Representable::Decorator
    include Representable::JSON

    property :id
    property :restaurant, exec_context: :decorator
    property :seats
    property :description

    def restaurant
      represented.restaurant.name
    end
  end
end
