# frozen_string_literal: true

module Operations
  module ReservationOperations
    # Operation to create Reservations with Facebook
    class Create < Trailblazer::Operation
      pass :new_model
      pass :validate_reservation
      pass :generate_customer_code
      pass :save_model
      pass :find_restaurant
      pass :send_mail
      pass :add_job
      pass :representer

      def new_model(options, **)
        options[:model] = Reservation.new
      end

      def validate_reservation(options, params:, **)
        options[:form] = Forms::ReservationForm.new(options[:model])

        raise CustomError.new(nil, nil, nil, options[:form].errors.messages) unless options[:form].validate(params)
      end

      def generate_customer_code(options, **)
        options[:customer_code] = Faker::IDNumber.valid
      end

      def save_model(options, **)
        options[:form].model.customer_code = options[:customer_code]
        options[:form].model.status = 1
        raise CustomError.new(nil, nil, nil, options[:form].model.errors) unless options[:form].save
      end

      def find_restaurant(options, model:, **)
        options[:restaurant] = model.table.restaurant
      end

      def send_mail(options, model:, user:, **)
        UserMailer.with(customer: user, restaurant: options[:restaurant],
                        reservation: model).customer_code_email.deliver_later
      end

      def add_job(_options, model:, **)
        ReservationCancelationJob.set(wait_until: model.datetime + 30.minutes).perform_later(model)
      end

      def representer(options, model:, **)
        options[:model] = Representers::ReservationRepresenter.new(model)
      end
    end
  end
end
