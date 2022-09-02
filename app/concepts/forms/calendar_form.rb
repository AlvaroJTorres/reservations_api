# frozen_string_literal: true

module Forms
  # Form object for Calendar Model
  class CalendarForm < Reform::Form
    property :restaurant_id
    property :date
    property :reason

    validates :restaurant_id, :date, :reason, presence: true

    validate :date_format

    private

    def date_format
      errors.add(:date, :date, message: 'Wrong date format') unless date =~ /\d{2}\/\d{2}\/\d{4}/
    end
  end
end
