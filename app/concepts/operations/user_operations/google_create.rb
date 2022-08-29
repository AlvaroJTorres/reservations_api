# frozen_string_literal: true

require 'open-uri'

module Operations
  module UserOperations
    # Operation to create Users with Facebook
    class GoogleCreate < Trailblazer::Operation
      pass :new_model
      pass :user_data
      pass :grab_image
      pass :save_model

      def new_model(options, **)
        options[:model] = User.new
      end

      def user_data(options, params:, **)
        options[:user_data] = {
          name: params['displayName'],
          email: params['emails'][0]['value'],
          gmail_id: params['id'],
          role: 0
        }
      end

      def grab_image(options, params:, **)
        options[:avatar] = URI.parse(params['image']['url']).open
      end

      def save_model(options, **)
        options[:model].attributes = options[:user_data]
        options[:model].avatar.attach(io: options[:avatar], filename: "image#{options[:user_data][:name]}.jpg")
        options[:model].save
      end
    end
  end
end
