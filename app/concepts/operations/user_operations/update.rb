# frozen_string_literal: true

module Operations
  module UserOperations
    # Operation to update Users on API
    class Update < Trailblazer::Operation
      pass :find_user
      step :validate_user
      fail :validations_errors!
      step :update_model
      step :representer

      def find_user(options, id:, **)
        options[:model] = User.find_by!(id: id)
      end

      def validate_user(options, params:, **)
        options[:form] = Forms::UserForm.new(options[:model])
        options[:form].validate(params)
      end

      def validations_errors!(options, **)
        raise CustomError.new(nil, nil, nil, options[:form].errors.messages)
      end

      def update_model(options, params:, **)
        options[:model].update(params)
      end

      def representer(options, model:, **)
        options[:model] = Representers::UserRepresenter.new(model)
      end
    end
  end
end
