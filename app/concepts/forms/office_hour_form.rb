# frozen_string_literal: true

module Forms
  # Form object for Office Hour Model
  class OfficeHourForm < Reform::Form
    property :day
    property :open
    property :close

    validates :day, :open, :close, presence: true

    validate :correct_open_hour

    validate :correct_close_hour

    private

    def correct_open_hour
      return if open < close

      errors.add(:open, :open, message: 'Open hour must be before close hour')
    end

    def correct_close_hour
      return if close > open

      errors.add(:open, :open, message: 'Close hour must be after open hour')
    end
  end
end
