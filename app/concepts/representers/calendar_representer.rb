# frozen_string_literal: true

module Representers
  # Representable decorator for User JSON
  class CalendarRepresenter < Representable::Decorator
    include Representable::JSON

    property :id
    property :restaurant_id
    property :date
    property :reason
  end
end
