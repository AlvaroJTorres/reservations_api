# frozen_string_literal: true

module Representers
  # Representable decorator for User JSON
  class UserRepresenter < Representable::Decorator
    include Representable::JSON

    property :id
    property :name
    property :email
    property :role
    property :avatar_url, exec_context: :decorator

    def avatar_url
      represented.avatar.url
    end
  end
end
