# frozen_string_literal: true

module Querys
  # Queries for Reservation Model
  class ReservationsQuery
    attr_reader :relation

    def initialize(restaurant = nil, relation = Reservation.all)
      @relation = relation
      @restaurant = restaurant
      @time_range = DateTime.now.midnight..(DateTime.now.midnight + 1.day)
    end

    def daily_reservations
      relation.joins(table: :restaurant).where('restaurant_id = ?', @restaurant.id).where('datetime' => @time_range)
    end
  end
end
