# frozen_string_literal: true

class User < ApplicationRecord
  has_one_attached :avatar
  has_one :restaurant

  enum role: { customer: 0, admin: 1, manager: 2 }
end
