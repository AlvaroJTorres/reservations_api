# frozen_string_literal: true

# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview
  def customer_code_email
    UserMailer.with(customer: User.find(3), restaurant: Restaurant.find(1), reservation: Reservation.find(6)).customer_code_email
  end

  def daily_report_email
    UserMailer.with(manager: User.find(2), reservations: 10, concurred_hours: concurred_hours).daily_report_email
  end

  private

  def concurred_hours
    {
      '"05/09/2022-11:00"': 3,
      '"05/09/2022-16:00"': 3
    }
  end
end
