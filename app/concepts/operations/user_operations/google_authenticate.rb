# frozen_string_literal: true

require 'faraday'
require 'faraday/net_http'
Faraday.default_adapter = :net_http

module Operations
  module UserOperations
    # Operation for authenticate users log in or sing up from google
    class GoogleAuthenticate < Trailblazer::Operation
      pass :define_connections
      pass :define_response
      pass :define_user_data
      pass :define_user

      def define_connections(options, **)
        options[:google_conn] = Faraday.new(
          url: 'https://www.googleapis.com/plus/v1/people'
        )
      end

      def define_response(options, params:, **)
        options[:response] = options[:google_conn].get('me') do |req|
          req.params['access_token'] = params[:assertion]
        end
      end

      def define_user_data(options, **)
        raise StandardError, 'Empty Body' unless options[:response].body

        options[:user_data] = JSON.parse(options[:response].body)
      end

      def define_user(options, **)
        user_by_id = User.find_by(gmail_id: options[:user_data]['id'])
        user_by_email = User.find_by(email: options[:user_data]['emails'][0]['value'])

        options[:model] = if user_by_id
                            user_by_id
                          elsif user_by_email
                            google_id_to_manager(user_by_email, options[:user_data])
                          else
                            result = Operations::UserOperations::GoogleCreate.call(params: options[:user_data])
                            result[:model]
                          end
      end

      private

      def google_id_to_manager(model, user_data)
        model.gmail_id = user_data['id']
        model.save
      end
    end
  end
end
