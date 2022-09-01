# frozen_string_literal: true

module Querys
  # Queries for Table Model
  class TablesQuery
    attr_reader :relation

    def initialize(restaurant = nil, relation = Table.where('deleted_at IS NULL'))
      @relation = relation
      @restaurant = restaurant
    end

    def available_tables(datetime)
      return @restaurant.tables.where('deleted_at IS NULL') unless datetime.present?

      check_available(datetime)

      @restaurant.tables.where('deleted_at IS NULL').where.not(id: @restaurant.tables.joins(:reservations)
                                                    .where('reservations.datetime' => datetime)
                                                    .where.not('reservations.status = 0').ids)
    end

    private

    def get_hour(datetime)
      datetime.slice(datetime.index('-') + 1..datetime.length - 1)
    end

    def check_available(datetime)
      raise CustomError.new('restaurant', 'Restaurant is closed') unless @restaurant&.office_hours&.where(
        'open <= :hour  AND :hour <= close', hour: get_hour(datetime)
      )&.find_by(day: DateTime.parse(datetime).strftime('%u'))
    end
  end
end
