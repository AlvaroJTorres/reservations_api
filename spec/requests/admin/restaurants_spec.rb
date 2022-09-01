# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe '/admin/restaurants', type: :request do
  path '/admin/restaurants' do
    post('create a restaurant') do
      tags 'Restaurants'
      consumes 'application/json'
      security [Bearer: {}]
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
        let(:restaurant) { { data: { name: 'New Restaurant', address: 'New address' } } }
        run_test!
      end

      response '201', :created do
        let!(:user) { create(:user, role: 1) }
        let(:Authorization) { "Bearer #{create(:access_token, resource_owner_id: user.id, scopes: 'admin').token}" }
        let(:restaurant) { { data: { name: 'New Restaurant', address: 'New address' } } }
        run_test!
      end

      response '422', :invalid_request do
        let!(:user) { create(:user, role: 1) }
        let(:Authorization) { "Bearer #{create(:access_token, resource_owner_id: user.id, scopes: 'admin').token}" }
        let(:restaurant) { { data: { name: '' } } }
        run_test!
      end
    end
  end

  path '/admin/restaurants/{id}' do
    patch('update restaurant') do
      tags 'Restaurants'
      parameter name: 'id', in: :path, type: :integer, description: 'id'
      security [Bearer: {}]
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
        let!(:id) { create(:restaurant).id }
        let(:Authorization) { '' }
        let(:restaurant) { { data: { name: 'Update Restaurant' } } }
        run_test!
      end

      response '200', :success do
        let!(:user) { create(:user, role: 1) }
        let!(:id) { create(:restaurant).id }
        let(:Authorization) { "Bearer #{create(:access_token, resource_owner_id: user.id, scopes: 'admin').token}" }
        let(:restaurant) { { data: { name: 'Update Restaurant' } } }
        run_test!
      end
    end

    delete('delete restaurant') do
      tags 'Restaurants'
      parameter name: 'id', in: :path, type: :integer, description: 'id'
      security [Bearer: {}]

      response '204', :no_content do
        let(:user) { create(:user, role: 1) }
        let(:Authorization) { "Bearer #{create(:access_token, resource_owner_id: user.id, scopes: 'admin').token}" }
        let(:id) { create(:restaurant).id }
        run_test!
      end

      response '401', :unauthorized do
        let!(:id) { create(:restaurant).id }
        let(:Authorization) { '' }
        let(:restaurant) { create(:restaurant) }
        run_test!
      end
    end
  end
end
