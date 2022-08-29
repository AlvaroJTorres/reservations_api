# frozen_string_literal: true

module Forms
  # Form object for Calendar Model
  class CalendarForm < Reform::Form
    property :restaurant_id
    property :date
    property :reason

    validates :restaurant_id, :date, :reason, presence: true
  end
end
