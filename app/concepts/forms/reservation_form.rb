# frozen_string_literal: true

module Forms
  # Form object for Reservation Model
  class ReservationForm < Reform::Form
    property :table_id
    property :datetime

    validates :table_id, :datetime, presence: true

    validate :check_day

    validate :check_office_hours

    validate :check_reserved

    private

    def find_restaurant
      Table.find(table_id)&.restaurant
    end

    def get_hour(datetime)
      datetime.slice(datetime.index('-') + 1..datetime.length - 1)
    end

    def check_day
      return unless find_restaurant&.calendars&.find_by(date: datetime)

      errors.add(:datetime, :datetime, message: 'Restaurant is closed that day')
    end

    def check_office_hours
      return if find_restaurant&.office_hours&.where(
        'open <= :hour  AND :hour <= close', hour: get_hour(datetime)
      )&.find_by(day: DateTime.parse(datetime).strftime('%u'))

      errors.add(:datetime, :datetime, message: 'Restaurant is closed at that hour')
    end

    def check_reserved
      errors.add(:table_id, :table_id, message: 'Table already reserved') if Reservation.where.not(status: 0).find_by(
        datetime: DateTime.parse(datetime), table_id: table_id
      )
    end
  end
end
