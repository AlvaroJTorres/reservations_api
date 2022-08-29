# frozen_string_literal: true

module Operations
  module CalendarOperations
    # Operation to update Calendars on API
    class Update < Trailblazer::Operation
      pass :find_restaurant
      pass :find_user
      step :validate_calendar
      fail :validations_errors!
      step :update_model
      step :representer

      def find_restaurant(options, restaurant_id:, **)
        options[:restaurant] = Restaurant.find_by!(id: restaurant_id)
      end

      def find_user(options, calendar_id:, **)
        options[:model] = options[:restaurant].calendars.find_by!(id: calendar_id)
      end

      def validate_calendar(options, params:, **)
        options[:form] = Forms::CalendarForm.new(options[:model])
        options[:form].validate(params)
      end

      def validations_errors!(options, **)
        raise CustomError.new(nil, nil, nil, options[:form].errors.messages)
      end

      def update_model(options, params:, **)
        options[:model].update(params)
      end

      def representer(options, model:, **)
        options[:model] = Representers::CalendarRepresenter.new(model)
      end
    end
  end
end
