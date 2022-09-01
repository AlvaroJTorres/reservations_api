# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe 'manager/calendars', type: :request do
  path '/manager/restaurants/{restaurant_id}/calendars' do
    parameter name: 'restaurant_id', in: :path, type: :string, description: 'restaurant_id'

    post('create calendar') do
      tags 'Calendars'
      parameter name: 'Authorization', in: :header, type: :string, default: 'Bearer '
      parameter name: :calendar, in: :body, schema: {
        type: :object,
        properties:
        {
          data: {
            type: :object,
            properties: {
              date: { type: :string, format: :datetime },
              reason: { type: :string }
            }
          }
        },
        required: %w[date]
      }

      response '401', :unauthorized do
        let(:Authorization) { '' }
        let(:restaurant)  { create(:restaurant) }
        let(:calendar)    { create(:calendar, restaurant_id: restaurant.id) }
        run_test!
      end

      response '201', :created do
        let(:user) { create(:user, role: 2) }
        let(:Authorization) { "Bearer #{create(:access_token, resource_owner_id: user.id, scopes: 'manager')}" }
        let(:restaurant)  { create(:restaurant) }
        let(:calendar)    { create(:calendar, restaurant_id: restaurant.id) }
        run_test!
      end

      response '422', :invalid_request do
        let(:user) { create(:user, role: 2) }
        let(:Authorization) { "Bearer #{create(:access_token, resource_owner_id: user.id, scopes: 'manager')}" }
        let(:restaurant)  { create(:restaurant) }
        let(:calendar)    { create(:calendar, date: '') }
        run_test!
      end
    end
  end

  path '/manager/restaurants/{restaurant_id}/calendars/{id}' do
    parameter name: 'restaurant_id', in: :path, type: :string, description: 'restaurant_id'
    parameter name: 'id', in: :path, type: :string, description: 'id'

    patch('update calendar') do
      tags 'Calendars'
      parameter name: 'Authorization', in: :header, type: :string, default: 'Bearer '
      parameter name: :calendar, in: :body, schema: {
        type: :object,
        properties:
        {
          data: {
            type: :object,
            properties: {
              date: { type: :string, format: :datetime },
              reason: { type: :string }
            }
          }
        }
      }

      response '401', :unauthorized do
        let(:Authorization) { '' }
        let(:restaurant)  { create(:restaurant) }
        let(:calendar)    { create(:calendar, restaurant_id: restaurant.id) }
        run_test!
      end

      response '200', :success do
        let(:user) { create(:user, role: 2) }
        let(:Authorization) { "Bearer #{create(:access_token, resource_owner_id: user.id, scopes: 'manager')}" }
        let(:restaurant)  { create(:restaurant) }
        let(:calendar)    { { date: '2000/01/01' } }
        run_test!
      end
    end

    delete('delete calendar') do
      tags 'Calendars'
      parameter name: 'Authorization', in: :header, type: :string, default: 'Bearer '

      response '204', :no_content do
        let(:user) { create(:user, role: 2) }
        let(:Authorization) { "Bearer #{create(:access_token, resource_owner_id: user.id, scopes: 'manager')}" }
        let(:restaurant)  { create(:restaurant) }
        let(:calendar)    { create(:calendar, restaurant_id: restaurant.id) }
        run_test!
      end

      response '401', :unauthorized do
        let(:Authorization) { '' }
        let(:restaurant)  { create(:restaurant) }
        let(:calendar)    { create(:calendar, restaurant_id: restaurant.id) }
        run_test!
      end
    end
  end
end
