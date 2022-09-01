# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe 'admin/users', type: :request do
  path '/admin/users' do
    get('list managers') do
      tags 'Managers'
      parameter name: 'Authorization', in: :header, type: :string, default: 'Bearer '
      response '200', :success do
        schema type: :object,
               properties: {
                 collection: {
                   type: :array,
                   items: {
                     type: :object,
                     properties: {
                       id: { type: :integer },
                       name: { type: :string },
                       email: { type: :string },
                       role: { type: :string }
                     }
                   }
                 }
               }
        run_test!
      end
    end

    post('create manager') do
      response(200, 'successful') do
        tags 'Managers'
        consumes 'application/json'
        parameter name: 'Authorization', in: :header, type: :string, default: 'Bearer '
        parameter name: :user, in: :body, schema: {
          type: :object,
          properties:
        {
          data: {
            type: :object,
            properties: {
              name: { type: :string },
              email: { type: :string },
              restaurant_id: { type: :integer }
            }
          }
        },
          required: %w[name address]
        }

        response '401', :unauthorized do
          let(:Authorization) { '' }
          let(:restaurant) { { name: 'New Restaurant', address: 'New address' } }
          let(:user) { { name: 'New User', email: 'newemail@mail.com', restaurant_id: restaurant.id } }
          run_test!
        end

        response '201', :created do
          let!(:user) { create(:user, role: 1) }
          let(:Authorization) { "Bearer #{create(:access_token, resource_owner_id: user.id, scopes: 'admin')}" }
          let(:restaurant) { { name: 'New Restaurant', address: 'New address' } }
          let(:manager) { { name: 'New User', email: 'newemail@mail.com', restaurant_id: restaurant.id } }
          run_test!
        end

        response '422', :invalid_request do
          let!(:user) { create(:user, role: 1) }
          let(:Authorization) { "Bearer #{create(:access_token, resource_owner_id: user.id, scopes: 'admin')}" }
          let(:restaurant) { { name: 'New Restaurant', address: 'New address' } }
          let(:manager) { { name: 'New User' } }
          run_test!
        end
      end
    end

    path '/admin/users/{id}' do
      patch('update manager') do
        tags 'Managers'
        parameter name: 'id', in: :path, type: :string, description: 'id'
        parameter name: 'Authorization', in: :header, type: :string, default: 'Bearer '
        parameter name: :user, in: :body, schema: {
          type: :object,
          properties:
        {
          data: {
            type: :object,
            properties: {
              name: { type: :string },
              email: { type: :string },
              restaurant_id: { type: :integer }
            }
          }
        }
        }

        response '401', :unauthorized do
          let(:Authorization) { '' }
          let(:restaurant) { { name: 'New Restaurant', address: 'New address' } }
          let(:manager) { { name: 'New User', email: 'newemail@mail.com', restaurant_id: restaurant.id } }
          run_test!
        end

        response '200', :success do
          let!(:user) { create(:user, role: 1) }
          let(:Authorization) { "Bearer #{create(:access_token, resource_owner_id: user.id, scopes: 'admin')}" }
          let(:restaurant) { { name: 'New Restaurant', address: 'New address' } }
          let(:manager) { { name: 'Update Manager' } }
          run_test!
        end

        response '422', :invalid_request do
          let!(:user) { create(:user, role: 1) }
          let(:Authorization) { "Bearer #{create(:access_token, resource_owner_id: user.id, scopes: 'admin')}" }
          let(:restaurant) { { name: 'New Restaurant', address: 'New address' } }
          let(:manager) { { name: '' } }
          run_test!
        end
      end
    end
  end
end
