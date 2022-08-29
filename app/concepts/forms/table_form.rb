# frozen_string_literal: true

module Forms
  # Form object for Table Model
  class TableForm < Reform::Form
    property :seats
    property :description

    validates :seats, presence: true, numericality: true
  end
end
