# frozen_string_literal: true

class Restaurant < ApplicationRecord
  has_many_attached :images
  belongs_to :user, optional: true
  has_many :tables
  has_many :calendars
  has_many :office_hours
end
