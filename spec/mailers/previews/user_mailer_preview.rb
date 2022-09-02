# frozen_string_literal: true

# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview
  def customer_code_email
    UserMailer.with(customer: customer, restaurant: restaurant, reservation: reservation).customer_code_email
  end

  def daily_report_email
    UserMailer.with(manager: manager, reservations: 10, concurred_hours: concurred_hours).daily_report_email
  end

  private

  def customer
    Struct.new(:email, :name).new('jillsmith@example.com', 'Jill Smith')
  end

  def restaurant
    OpenStruct.new(name: 'Test Restaurant', user: OpenStruct.new(email: 'manager@mail.com'))
  end

  def reservation
    Struct.new(:customer_code, :datetime).new('1234567890', DateTime.new)
  end

  def manager
    OpenStruct.new(name: 'Alberto Perez', email: 'manager@mail.com', restaurant: OpenStruct.new(name: 'Test Restaurant'))
  end

  def concurred_hours
    {
      '11:00 AM': 3,
      '04:00 PM': 3
    }
  end
end
