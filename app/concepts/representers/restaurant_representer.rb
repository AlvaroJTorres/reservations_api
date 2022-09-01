# frozen_string_literal: true

module Representers
  # Representable decorator for User JSON
  class RestaurantRepresenter < Representable::Decorator
    include Representable::JSON

    property :id
    property :name
    property :address
    property :manager, exec_context: :decorator
    collection :tables, decorator: TableRepresenter
    collection :images, decorator: ImageRepresenter

    def manager
      represented.user_id
    end
  end
end
