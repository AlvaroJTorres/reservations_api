# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe 'manager/office_hours', type: :request do
  path '/manager/restaurants/{restaurant_id}/office_hours' do
    parameter name: 'restaurant_id', in: :path, type: :string, description: 'restaurant_id'

    post('create office_hour') do
      tags 'Office Hours'
      consumes 'application/json'
      security [Bearer: {}]
      parameter name: :office_hour, in: :body, schema: {
        type: :object,
        properties:
        {
          data: {
            type: :object,
            properties: {
              day: { type: :integer },
              open: { type: :string, format: :time },
              close: { type: :string, format: :time }
            }
          }
        },
        required: %w[day open close]
      }

      response '401', :unauthorized do
        let(:Authorization) { '' }
        let(:restaurant_id) { create(:restaurant).id }
        let(:office_hour)   { { data: { day: 1, open: '09:00', close: '20:00' } } }
        run_test!
      end

      response '201', :created do
        let!(:user) { create(:user, role: 2) }
        let(:Authorization) { "Bearer #{create(:access_token, resource_owner_id: user.id, scopes: 'manager').token}" }
        let(:restaurant_id) { create(:restaurant).id }
        let(:office_hour)   { { data: { day: 1, open: '09:00', close: '20:00' } } }
        run_test!
      end

      response '422', :invalid_request do
        let!(:user) { create(:user, role: 2) }
        let(:Authorization) { "Bearer #{create(:access_token, resource_owner_id: user.id, scopes: 'manager').token}" }
        let(:restaurant_id) { create(:restaurant).id }
        let(:office_hour)   { { data: { day: '', open: '', close: '' } } }
        run_test!
      end
    end
  end

  path '/manager/restaurants/{restaurant_id}/office_hours/{id}' do
    parameter name: 'restaurant_id', in: :path, type: :string, description: 'restaurant_id'
    parameter name: 'id', in: :path, type: :string, description: 'id'

    patch('update office_hour') do
      tags 'Office Hours'
      security [Bearer: {}]
      parameter name: :office_hour, in: :body, schema: {
        type: :object,
        properties:
        {
          data: {
            type: :object,
            properties: {
              day: { type: :integer },
              open: { type: :string, format: :time },
              close: { type: :string, format: :time }
            }
          }
        }
      }

      response '401', :unauthorized do
        let(:Authorization) { '' }
        let(:restaurant_id) { create(:restaurant).id }
        let(:id) { create(:office_hour, restaurant_id: restaurant_id).id }
        let(:office_hour) { { data: { day: 3 } } }
        run_test!
      end

      response '200', :success do
        let!(:user) { create(:user, role: 2) }
        let(:Authorization) { "Bearer #{create(:access_token, resource_owner_id: user.id, scopes: 'manager').token}" }
        let(:restaurant_id) { create(:restaurant).id }
        let(:id) { create(:office_hour, restaurant_id: restaurant_id).id }
        let(:office_hour) { { data: { day: 3 } } }
        run_test!
      end
    end

    delete('delete office_hour') do
      tags 'Office Hours'
      security [Bearer: {}]

      response '204', :no_content do
        let!(:user) { create(:user, role: 2) }
        let(:Authorization) { "Bearer #{create(:access_token, resource_owner_id: user.id, scopes: 'manager').token}" }
        let(:restaurant_id) { create(:restaurant).id }
        let(:id) { create(:office_hour, restaurant_id: restaurant_id).id }
        run_test!
      end

      response '401', :unauthorized do
        let(:Authorization) { '' }
        let(:restaurant_id) { create(:restaurant).id }
        let(:id) { create(:office_hour, restaurant_id: restaurant_id).id }
        run_test!
      end
    end
  end
end
