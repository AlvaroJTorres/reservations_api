# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe 'customer/reservations', type: :request do
  path '/customer/reservations' do
    post('create reservation') do
      tags 'Reservations'
      consumes 'application/json'
      security [Bearer: {}]
      parameter name: :reservation, in: :body, schema: {
        type: :object,
        properties:
        {
          data: {
            type: :object,
            properties: {
              table_id: { type: :integer },
              datetime: { type: :string, format: :datetime }
            }
          }
        },
        required: %w[table_id datetime]
      }

      response '401', :unauthorized do
        let(:Authorization) { '' }
        let(:restaurant) { create(:restaurant) }
        let(:table) { create(:table, restaurant_id: restaurant.id) }
        let(:office_hour) { create(:office_hour, restaurant_id: restaurant.id) }
        let(:reservation) { { table_id: table.id, datetime: '05/09/2022-11:00' } }
        run_test!
      end

      response '201', :created do
        let!(:user) { create(:user) }
        let(:Authorization) { "Bearer #{create(:access_token, resource_owner_id: user.id, scopes: 'customer').token}" }
        let(:restaurant) do
          create(:restaurant) do |restaurant|
            create(:table, restaurant_id: restaurant.id)
            create(:calendar, restaurant_id: restaurant.id)
            create(:office_hour, restaurant_id: restaurant.id)
          end
        end
        let(:reservation) { { data: { table_id: restaurant.tables.first.id, datetime: '05/09/2022-16:00' } } }
        run_test!
      end

      response '422', :invalid_request do
        let!(:user) { create(:user, role: 2) }
        let(:Authorization) { "Bearer #{create(:access_token, resource_owner_id: user.id, scopes: 'customer').token}" }
        let(:restaurant) do
          create(:restaurant) do |restaurant|
            create(:table, restaurant_id: restaurant.id)
            create(:calendar, restaurant_id: restaurant.id)
            create(:office_hour, restaurant_id: restaurant.id)
          end
        end
        let(:reservation) { { data: { table_id: restaurant.tables.first.id, datetime: '06/09/2022-16:00' } } }
        run_test!
      end
    end
  end
end
