# frozen_string_literal: true

# Mailers for Users
class UserMailer < ApplicationMailer
  def customer_code_email
    @customer = params[:customer]
    @restaurant = params[:restaurant]
    @reservation = params[:reservation]

    mail(from: @restaurant.user.email, to: @customer.email, subject: 'Reservation Code')
  end
end
