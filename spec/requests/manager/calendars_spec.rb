# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe 'manager/calendars', type: :request do
  path '/manager/restaurants/{restaurant_id}/calendars' do
    parameter name: 'restaurant_id', in: :path, type: :integer, description: 'restaurant_id'

    post('create calendar') do
      tags 'Calendars'
      consumes 'application/json'
      security [Bearer: {}]
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
        let(:restaurant_id) { create(:restaurant).id }
        let(:calendar) { { data: { date: '12/02/2022' } } }
        run_test!
      end

      response '201', :created do
        let!(:user) { create(:user, role: 2) }
        let(:Authorization) { "Bearer #{create(:access_token, resource_owner_id: user.id, scopes: 'manager').token}" }
        let(:restaurant_id) { create(:restaurant).id }
        let(:calendar) { { data: { date: '12/02/2022' } } }
        run_test!
      end

      response '422', :invalid_request do
        let!(:user) { create(:user, role: 2) }
        let(:Authorization) { "Bearer #{create(:access_token, resource_owner_id: user.id, scopes: 'manager').token}" }
        let(:restaurant_id) { create(:restaurant).id }
        let(:calendar) { { data: { date: '' } } }
        run_test!
      end
    end
  end

  path '/manager/restaurants/{restaurant_id}/calendars/{id}' do
    parameter name: 'restaurant_id', in: :path, type: :integer, description: 'restaurant_id'
    parameter name: 'id', in: :path, type: :integer, description: 'id'

    patch('update calendar') do
      tags 'Calendars'
      security [Bearer: {}]
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
        let(:restaurant_id) { create(:restaurant).id }
        let(:id) { create(:calendar, restaurant_id: restaurant_id).id }
        let(:calendar) { { data: { reason: 'closed' } } }
        run_test!
      end

      response '200', :success do
        let!(:user) { create(:user, role: 2) }
        let(:Authorization) { "Bearer #{create(:access_token, resource_owner_id: user.id, scopes: 'manager').token}" }
        let(:restaurant_id) { create(:restaurant).id }
        let(:id) { create(:calendar, restaurant_id: restaurant_id).id }
        let(:calendar) { { data: { reason: 'closed' } } }
        run_test!
      end
    end

    delete('delete calendar') do
      tags 'Calendars'
      security [Bearer: {}]

      response '204', :no_content do
        let!(:user) { create(:user, role: 2) }
        let(:Authorization) { "Bearer #{create(:access_token, resource_owner_id: user.id, scopes: 'manager').token}" }
        let(:restaurant_id) { create(:restaurant).id }
        let(:id) { create(:calendar, restaurant_id: restaurant_id).id }
        run_test!
      end

      response '401', :unauthorized do
        let(:Authorization) { '' }
        let(:restaurant_id) { create(:restaurant).id }
        let(:id) { create(:calendar, restaurant_id: restaurant_id).id }
        run_test!
      end
    end
  end
end
