# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe '/oauth/token', type: :request do
  path '/oauth/token' do
    post('get access token') do
      tags 'Oauth'
      consumes 'application/json'
      parameter name: :token, in: :body, schema: {
        type: :object,
        properties:
        {
            grant_type: { type: :string },
            provider: { type: :string },
            assertion: { type: :string},
            scope: { type: :string }
        },
        required: %w[grant_type provider assertion scope]
      }

      response '401', :unauthorized do
        run_test!
      end

      response '200', :created do
        run_test!
      end
    end
  end
end