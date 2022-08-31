# frozen_string_literal: true

# Mailers for Users
class UserMailer < ApplicationMailer
  def customer_code_email
    @customer = params[:customer]
    @restaurant = params[:restaurant]
    @reservation = params[:reservation]

    mail(from: @restaurant.user.email, to: @customer.email, subject: 'Reservation Code', content_type: 'text/html')
  end

  def daily_report_email
    @manager = params[:manager]
    @reservations = params[:reservations]
    @concurred_hours = params[:concurred_hours]

    mail(to: @manager.email, subject: 'Daily Report', content_type: 'text/html')
  end
end
