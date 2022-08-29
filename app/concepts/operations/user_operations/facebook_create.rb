# frozen_string_literal: true

require 'open-uri'

module Operations
  module UserOperations
    # Operation to create Users with Facebook
    class FacebookCreate < Trailblazer::Operation
      pass :new_model
      pass :user_data
      pass :save_model

      def new_model(options, **)
        options[:model] = User.new
      end

      def user_data(options, params:, **)
        options[:user_data] = {
          name: params['name'],
          email: params['email'],
          facebook_id: params['id'],
          role: 0
        }
      end

      def save_model(options, **)
        options[:model].attributes = options[:user_data]
        options[:model].save
      end
    end
  end
end
