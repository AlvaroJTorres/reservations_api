# frozen_string_literal: true

module Operations
  module OfficeHourOperations
    # Operation to update Office Hours on API
    class Update < Trailblazer::Operation
      pass :find_restaurant
      pass :find_office_hour
      step :validate_office_hour
      fail :validations_errors!
      pass :update_model
      pass :representer

      def find_restaurant(options, restaurant_id:, **)
        options[:restaurant] = Restaurant.find_by!(id: restaurant_id)
      end

      def find_office_hour(options, office_hour_id:, **)
        options[:model] = options[:restaurant].office_hours.find_by!(id: office_hour_id)
      end

      def validate_office_hour(options, params:, **)
        options[:form] = Forms::OfficeHourForm.new(options[:model])
        options[:form].validate(params)
      end

      def validations_errors!(options, **)
        raise CustomError.new(nil, nil, nil, options[:form].errors.messages)
      end

      def update_model(options, params:, **)
        options[:model].update(params)
      end

      def representer(options, model:, **)
        options[:model] = Representers::OfficeHourRepresenter.new(model)
      end
    end
  end
end
