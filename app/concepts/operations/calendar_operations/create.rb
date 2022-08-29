# frozen_string_literal: true

module Operations
  module CalendarOperations
    # Operation to create Calendars with Facebook
    class Create < Trailblazer::Operation
      pass :find_restaurant
      pass :new_model
      pass :validate_calendar
      pass :save_model
      pass :representer

      def find_restaurant(options, restaurant_id:, **)
        options[:restaurant] = Restaurant.find_by!(id: restaurant_id)
      end

      def new_model(options, **)
        options[:model] = options[:restaurant].calendars.new
      end

      def validate_calendar(options, params:, **)
        options[:form] = Forms::CalendarForm.new(options[:model])

        raise CustomError.new(nil, nil, nil, options[:form].errors.messages) unless options[:form].validate(params)
      end

      def save_model(options, **)
        raise CustomError.new(nil, nil, nil, options[:form].model.errors) unless options[:form].save
      end

      def representer(options, model:, **)
        options[:model] = Representers::CalendarRepresenter.new(model)
      end
    end
  end
end
