# frozen_string_literal: true

module Operations
  module RestaurantOperations
    # Operation to update Restaurants on API
    class Update < Trailblazer::Operation
      pass :find_restaurant
      step :validate_restaurant
      fail :validations_errors!
      pass :update_model
      pass :representer

      def find_restaurant(options, id:, **)
        options[:model] = Restaurant.find_by(id: id)
      end

      def validate_restaurant(options, params:, **)
        options[:form] = Forms::RestaurantForm.new(options[:model])
        options[:form].validate(params)
      end

      def validations_errors!(options, **)
        raise CustomError.new(nil, nil, nil, options[:form].errors.messages)
      end

      def update_model(options, params:, **)
        options[:model].update(params)
      end

      def representer(options, model:, **)
        options[:model] = Representers::RestaurantRepresenter.new(model)
      end
    end
  end
end
