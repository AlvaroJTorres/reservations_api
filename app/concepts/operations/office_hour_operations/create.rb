# frozen_string_literal: true

module Operations
  module OfficeHourOperations
    # Operation to create Office Hours with Facebook
    class Create < Trailblazer::Operation
      pass :find_restaurant
      pass :new_model
      pass :validate_office_hour
      pass :save_model
      pass :representer

      def find_restaurant(options, restaurant_id:, **)
        options[:restaurant] = Restaurant.find_by!(id: restaurant_id)
      end

      def new_model(options, **)
        options[:model] = options[:restaurant].office_hours.new
      end

      def validate_office_hour(options, params:, **)
        options[:form] = Forms::OfficeHourForm.new(options[:model])

        raise CustomError.new(nil, nil, nil, options[:form].errors.messages) unless options[:form].validate(params)
      end

      def save_model(options, **)
        raise CustomError.new(nil, nil, nil, options[:form].model.errors) unless options[:form].save
      end

      def representer(options, model:, **)
        options[:model] = Representers::OfficeHourRepresenter.new(model)
      end
    end
  end
end
