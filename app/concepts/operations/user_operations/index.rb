# frozen_string_literal: true

module Operations
  module UserOperations
    # Operation to index Users on API
    class Index < Trailblazer::Operation
      step :user_scope
      step :representer

      def user_scope(options, **)
        options[:model] = Querys::UsersQuery.new.list_managers
      end

      def representer(options, model:, **)
        options[:model] = Representers::UserRepresenter.for_collection.new(model)
      end
    end
  end
end
