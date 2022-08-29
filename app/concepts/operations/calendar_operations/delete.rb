# frozen_string_literal: true

module Operations
  module CalendarOperations
    # Operation to delete Calendars on API
    class Delete < Trailblazer::Operation
      pass :find_restaurant
      pass :find_calendar
      pass :delete_calendar

      def find_restaurant(options, restaurant_id:, **)
        options[:restaurant] = Restaurant.find_by!(id: restaurant_id)
      end

      def find_calendar(options, calendar_id:, **)
        options[:model] = options[:restaurant].calendars.find_by(id: calendar_id)
      end

      def delete_calendar(options, **)
        options[:model].destroy
      end
    end
  end
end
