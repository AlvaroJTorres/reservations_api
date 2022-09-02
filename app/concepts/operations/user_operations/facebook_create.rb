# frozen_string_literal: true

require 'open-uri'

module Operations
  module UserOperations
    # Operation to create Users with Facebook
    class FacebookCreate < Trailblazer::Operation
      pass :new_model
      pass :user_data
      pass :save_model
      pass :grab_image
      pass :define_image_data
      pass :attach_image_to_user

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

      def grab_image(options, connection:, assertion:, **)
        options[:response] = connection.get("/#{options[:model].facebook_id}/picture?redirect=0") do |req|
          req.params['access_token'] = assertion
        end
      end

      def define_image_data(options, **)
        options[:avatar] = JSON.parse(options[:response].body)['data']['url']
        options[:avatar] = URI.parse(options[:avatar]).open
      end

      def attach_image_to_user(options, **)
        options[:model].avatar.attach(io: options[:avatar], filename: "image#{options[:model].name}.jpg")
        options[:model].save
      end
    end
  end
end
