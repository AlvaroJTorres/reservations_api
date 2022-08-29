# frozen_string_literal: true

module Operations
  module TableOperations
    # Operation to create Tables with Facebook
    class Create < Trailblazer::Operation
      pass :find_restaurant
      pass :new_model
      step :validate_table
      fail :validations_errors!
      pass :save_model
      pass :representer

      def find_restaurant(options, restaurant_id:, **)
        options[:restaurant] = Restaurant.find_by!(id: restaurant_id)
      end

      def new_model(options, **)
        options[:model] = options[:restaurant].tables.new
      end

      def validate_table(options, params:, **)
        options[:form] = Forms::TableForm.new(options[:model])
        options[:form].validate(params)
      end

      def validations_errors!(options, **)
        raise CustomError.new(nil, nil, nil, options[:form].errors.messages)
      end

      def save_model(options, **)
        raise CustomError.new(nil, nil, nil, options[:form].model.errors) unless options[:form].save
      end

      def representer(options, model:, **)
        options[:model] = Representers::TableRepresenter.new(model)
      end
    end
  end
end
