# frozen_string_literal: true

module Operations
  module UserOperations
    # Operation to index Users on API
    class Index < Trailblazer::Operation
      step :user_scope
      step :pagy_custom

      def user_scope(options, **)
        options[:model] = Querys::UsersQuery.new.list_managers
      end

      def pagy_custom(options, **)
        options[:pagy], options[:records] = options[:pagy_call].call(options[:model], items: 10)
        options[:records] = Representers::UserRepresenter.for_collection.new(options[:records])
      end
    end
  end
end
