# frozen_string_literal: true

class Calendar < ApplicationRecord
  belongs_to :restaurant

  enum reason: { holiday: 0, closed: 1 }
end
