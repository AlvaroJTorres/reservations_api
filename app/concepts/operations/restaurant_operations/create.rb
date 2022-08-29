# frozen_string_literal: true

module Operations
  module RestaurantOperations
    # Operation to create Restaurants with Facebook
    class Create < Trailblazer::Operation
      pass :new_model
      step :validate_restaurant
      fail :validations_errors!
      pass :save_model
      pass :representer

      def new_model(options, **)
        options[:model] = Restaurant.new
      end

      def validate_restaurant(options, params:, **)
        options[:form] = Forms::RestaurantForm.new(options[:model])
        options[:form].validate(params)
      end

      def validations_errors!(options, **)
        raise CustomError.new(nil, nil, nil, options[:form].errors.messages)
      end

      def save_model(options, **)
        raise CustomError.new(nil, nil, nil, options[:form].model.errors) unless options[:form].save
      end

      def representer(options, model:, **)
        options[:model] = Representers::RestaurantRepresenter.new(model)
      end
    end
  end
end
