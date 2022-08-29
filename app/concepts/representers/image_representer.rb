# frozen_string_literal: true

module Representers
  # Representable decorator for User JSON
  class ImageRepresenter < Representable::Decorator
    include Representable::JSON

    property :image_url, exec_context: :decorator

    def image_url
      represented.url
    end
  end
end
