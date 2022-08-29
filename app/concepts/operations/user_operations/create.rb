# frozen_string_literal: true

module Operations
  module UserOperations
    # Operation to create Users with Facebook
    class Create < Trailblazer::Operation
      pass :new_model
      pass :find_restaurant
      step :validate_user
      fail :validations_errors!
      pass :validate_restaurant
      pass :save_model
      pass :assing_restaurant
      pass :representer

      def new_model(options, **)
        options[:model] = User.new
      end

      def validate_user(options, params:, **)
        options[:form] = Forms::UserForm.new(options[:model])
        options[:form].validate(params)
      end

      def validations_errors!(options, **)
        raise CustomError.new(nil, nil, nil, options[:form].errors.messages)
      end

      def find_restaurant(options, params:, **)
        options[:restaurant] = Restaurant.find_by!(id: params[:restaurant_id])
      end

      def validate_restaurant(options, **)
        return if options[:restaurant].user_id.nil?

        raise CustomError.new('restaurant_id', 'Restaurant already has a manager', nil, nil)
      end

      def save_model(options, **)
        options[:form].model.role = 2
        raise CustomError.new(nil, nil, nil, options[:form].model.errors) unless options[:form].save
      end

      def assing_restaurant(options, **)
        options[:restaurant].user_id = options[:model].id

        raise CustomError.new(nil, nil, nil, options[:form].model.errors) unless options[:restaurant].save
      end

      def representer(options, model:, **)
        options[:model] = Representers::UserRepresenter.new(model)
      end
    end
  end
end
