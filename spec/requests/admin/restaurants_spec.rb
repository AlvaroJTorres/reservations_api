# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe '/admin/restaurants', type: :request do
  path '/admin/restaurants' do
    post('create a restaurant') do
      tags 'Restaurants'
      consumes 'application/json'
      parameter name: 'Authorization', in: :header, type: :string, default: 'Bearer '
      parameter name: :restaurant, in: :body, schema: {
        type: :object,
        properties:
        {
          data: {
            type: :object,
            properties: {
              name: { type: :string },
              address: { type: :string }
            }
          }
        },
        required: %w[name address]
      }

      response '401', :unauthorized do
        let(:Authorization) { '' }
        let(:restaurant) { { title: 'Updated Restaurant', address: 'Updated address' } }
        run_test!
      end

      response '201', :created do
        let!(:user) { create(:user, role: 1) }
        let(:Authorization) { "Bearer #{create(:access_token, resource_owner_id: user.id, scopes: 'admin')}" }
        let(:restaurant) { { name: 'New Restaurant', address: 'New address' } }
        run_test!
      end

      response '422', :invalid_request do
        let!(:user) { create(:user, role: 1) }
        let(:Authorization) { "Bearer #{create(:access_token, resource_owner_id: user.id, scopes: 'admin')}" }
        let(:restaurant) { { name: '' } }
        run_test!
      end
    end
  end

  path '/admin/restaurants/{id}' do
    patch('update restaurant') do
      tags 'Restaurants'
      parameter name: 'id', in: :path, type: :integer, description: 'id'
      parameter name: 'Authorization', in: :header, type: :string, default: 'Bearer '
      parameter name: :restaurant, in: :body, schema: {
        type: :object,
        properties:
        {
          data: {
            type: :object,
            properties: {
              name: { type: :string },
              address: { type: :string }
            }
          }
        },
        required: %w[name address]
      }

      response '401', :unauthorized do
        let(:Authorization) { '' }
        let(:restaurant) { { title: 'Updated Restaurant', address: 'Updated address' } }
        run_test!
      end

      response '200', :success do
        let(:user) { create(:user, role: 1) }
        let(:id) { create(:restaurant).id }
        let(:Authorization) { "Bearer #{create(:access_token, resource_owner_id: user.id, scopes: 'admin')}" }
        let(:restaurant) { { title: 'Updated Restaurant', address: 'Updated address' } }
        run_test!
      end
    end

    delete('delete restaurant') do
      tags 'Restaurants'
      parameter name: :id, in: :path, type: :integer
      parameter name: 'Authorization', in: :header, type: :string, default: 'Bearer '

      response '204', :no_content do
        let(:user) { create(:user, role: 1) }
        let(:Authorization) { "Bearer #{create(:access_token, resource_owner_id: user.id, scopes: 'admin')}" }
        let(:id) { create(:restaurant).id }
        run_test!
      end

      response '401', :unauthorized do
        let(:Authorization) { '' }
        let(:restaurant) { { title: 'Updated Restaurant', address: 'Updated address' } }
        run_test!
      end
    end
  end
end
