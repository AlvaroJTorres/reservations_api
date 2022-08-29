# frozen_string_literal: true

require 'faraday'
require 'faraday/net_http'
Faraday.default_adapter = :net_http

module Operations
  module UserOperations
    # Operation for authenticate users log in or sing up from facebook
    class FacebookAuthenticate < Trailblazer::Operation
      pass :define_connections
      pass :define_response
      pass :define_user_data
      pass :define_user

      def define_connection(options, **)
        p 'DEFINE CONNECTION'
        options[:fb_conn] = Faraday.new(
          url: 'https://graph.facebook.com',
          headers: { 'Content-Type' => 'application/json' }
        )
      end

      def define_response(options, params:, **)
        p 'DEFINE RESPONSE'
        options[:response] = options[:fb_conn].get('/me?fields=id,name,email') do |req|
          req.params['access_token'] = params[:assertion]
        end
      end

      def define_user_data(options, **)
        p '***************************************** USER'
        raise StandardError, 'Empty Body' unless options[:response].body

        options[:user_data] = JSON.parse(options[:response].body)
      end

      def define_user(options, **)
        options[:model] = if User.find_by(facebook_id: options[:user_data]['id'])
                            User.find_by(facebook_id: options[:user_data]['id'])
                          else
                            result = Operations::UserOperations::FacebookCreate.call(params: options[:user_data])
                            result[:model]
                          end
      end
    end
  end
end
