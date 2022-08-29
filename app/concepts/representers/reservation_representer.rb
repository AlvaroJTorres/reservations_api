# frozen_string_literal: true

module Representers
  # Representable decorator for Reservation JSON
  class ReservationRepresenter < Representable::Decorator
    include Representable::JSON

    property :id
    property :table_id
    property :restaurant, exec_context: :decorator
    property :datetime
    property :status
    property :customer_code

    def restaurant
      represented.table.restaurant.name
    end
  end
end
