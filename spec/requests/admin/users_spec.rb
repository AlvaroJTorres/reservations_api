# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe 'admin/users', type: :request do
  path '/admin/users' do
    get('list managers') do
      tags 'Managers'
      security [Bearer: {}]

      response '200', :success do
        schema type: :object,
               properties: {
                 data: {
                   type: :array,
                   properties: {
                     id: { type: :integer },
                     name: { type: :string },
                     email: { type: :string },
                     role: { type: :string }
                   }
                 }
               }

        let(:user) { create(:user, role: 2) }
        let(:Authorization) { "Bearer #{create(:access_token, resource_owner_id: user.id, scopes: 'admin').token}" }
        run_test!
      end
    end

    post('create manager') do
      tags 'Managers'
      consumes 'application/json'
      security [Bearer: {}]
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
        required: %w[name email restaurant_id]
      }

      response '401', :unauthorized do
        let!(:admin) { create(:user, role: 1) }
        let(:Authorization) { '' }
        let(:restaurant) { create(:restaurant) }
        let(:user) { { data: { name: 'New User', email: 'newemail@mail.com', restaurant_id: restaurant.id } } }
        run_test!
      end

      response '201', :created do
        let!(:admin) { create(:user, role: 1) }
        let(:Authorization) { "Bearer #{create(:access_token, resource_owner_id: admin.id, scopes: 'admin').token}" }
        let(:restaurant) { create(:restaurant) }
        let(:user) { { data: { name: 'New User', email: 'newemail@mail.com', restaurant_id: restaurant.id } } }
        run_test!
      end

      response '422', :invalid_request do
        let!(:admin) { create(:user, role: 1) }
        let(:Authorization) { "Bearer #{create(:access_token, resource_owner_id: admin.id, scopes: 'admin').token}" }
        let(:restaurant) { create(:restaurant) }
        let(:user) { { data: { name: '', email: '', restaurant_id: restaurant.id } } }
        run_test!
      end
    end

    path '/admin/users/{id}' do
      patch('update manager') do
        tags 'Managers'
        parameter name: 'id', in: :path, type: :integer, description: 'id'
        security [Bearer: {}]
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
          let!(:admin) { create(:user, role: 1) }
          let!(:id) { create(:user).id }
          let(:Authorization) { '' }
          let(:restaurant) { create(:restaurant) }
          let(:user) { { data: { name: 'Update User' } } }
          run_test!
        end

        response '200', :success do
          let!(:admin) { create(:user, role: 1) }
          let!(:id) { create(:user).id }
          let(:Authorization) { "Bearer #{create(:access_token, resource_owner_id: admin.id, scopes: 'admin').token}" }
          let(:restaurant) { create(:restaurant) }
          let(:user) { { data: { name: 'Update User' } } }
          run_test!
        end

        response '422', :invalid_request do
          let!(:admin) { create(:user, role: 1) }
          let!(:id) { create(:user).id }
          let(:Authorization) { "Bearer #{create(:access_token, resource_owner_id: admin.id, scopes: 'admin').token}" }
          let(:restaurant) { create(:restaurant) }
          let(:user) { { data: { name: '' } } }
          run_test!
        end
      end
    end
  end
end
