# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe 'manager/tables', type: :request do
  path '/manager/restaurants/{restaurant_id}/tables' do
    parameter name: 'restaurant_id', in: :path, type: :string, description: 'restaurant_id'

    post('create table') do
      tags 'Tables'
      consumes 'application/json'
      parameter name: 'Authorization', in: :header, type: :string, default: 'Bearer '
      parameter name: :table, in: :body, schema: {
        type: :object,
        properties: {
          data: {
            type: :object,
            properties: {
              seats: { type: :integer },
              description: { type: :string }
            }
          }
        },
        required: %w[seats]
      }

      response '401', :unauthorized do
        let(:Authorization) { '' }
        let(:restaurant) { { title: 'Restaurant', address: 'Address' } }
        let(:table) { { seats: 2, description: 'Doc Table' } }
        run_test!
      end

      response '201', :created do
        let!(:user) { create(:user, role: 2) }
        let(:Authorization) { "Bearer #{create(:access_token, resource_owner_id: user.id, scopes: 'admin')}" }
        let(:restaurant) { { title: 'Restaurant', address: 'Address' } }
        let(:table) { { seats: 2, description: 'Doc Table' } }
        run_test!
      end

      response '422', :invalid_request do
        let!(:user) { create(:user, role: 2) }
        let(:Authorization) { "Bearer #{create(:access_token, resource_owner_id: user.id, scopes: 'admin')}" }
        let(:restaurant) { { title: 'Restaurant', address: 'Address' } }
        let(:table) { { seats: 2, description: 'Doc Table' } }
        run_test!
      end
    end
  end

  path '/manager/restaurants/{restaurant_id}/tables/{id}' do
    parameter name: 'restaurant_id', in: :path, type: :string, description: 'restaurant_id'
    parameter name: 'id', in: :path, type: :string, description: 'id'

    delete('delete table') do
      tags 'Tables'
      parameter name: 'Authorization', in: :header, type: :string, default: 'Bearer '

      response '204', :no_content do
        let!(:user) { create(:user, role: 2) }
        let(:Authorization) { "Bearer #{create(:access_token, resource_owner_id: user.id, scopes: 'admin')}" }
        let(:restaurant) { { title: 'Restaurant', address: 'Address' } }
        let(:table) { { seats: 2, description: 'Doc Table' } }
        run_test!
      end

      response '401', :unauthorized do
        let(:Authorization) { '' }
        let(:restaurant) { { title: 'Restaurant', address: 'Address' } }
        let(:table) { { seats: 2, description: 'Doc Table' } }
        run_test!
      end
    end
  end
end
