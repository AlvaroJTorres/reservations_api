# frozen_string_literal: true

module Forms
  # Form object for Office Hour Model
  class OfficeHourForm < Reform::Form
    property :day
    property :open
    property :close

    validates :day, :open, :close, presence: true
  end
end
