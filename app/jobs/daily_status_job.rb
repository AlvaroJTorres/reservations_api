# frozen_string_literal: true

# Active job to send daily reports to Managers
class DailyStatusJob < ApplicationJob
  queue_as :default

  def perform
    User.where(role: 2).each do |manager|
      daily_reservations = Querys::ReservationsQuery.new(manager.restaurant).daily_reservations

      UserMailer.with(manager: manager,
                      reservations: total_reservations(daily_reservations),
                      concurred_hours: concurred_hours(daily_reservations)).daily_report_email.deliver_later
    end
  end

  private

  def total_reservations(query)
    query.count
  end

  def concurred_hours(query)
    hash = query.group(:datetime).count
    hash.select { |_k, v| v == hash.values.max }.transform_keys { |k| k.strftime('%I:%M %p') }
  end
end
