# frozen_string_literal: true

module Representers
  # Representable decorator for User JSON
  class OfficeHourRepresenter < Representable::Decorator
    include Representable::JSON

    property :id
    property :restaurant, exec_context: :decorator
    property :day
    property :open
    property :close

    def restaurant
      represented.restaurant.name
    end
  end
end
