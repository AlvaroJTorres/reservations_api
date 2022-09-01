# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe 'customer/restaurants', type: :request do
  path '/customer/restaurants' do
    get('list restaurants') do
      tags 'Restaurants'
      security [Bearer: {}]

      response '200', :success do
        schema type: :object,
               properties:
        {
          data: {
            type: :array,
            properties: {
              id: { type: :integer },
              name: { type: :string },
              address: { type: :string },
              manager: { type: :integer },
              tables: {
                type: :array,
                properties: {
                  id: { type: :integer },
                  restaurant_id: { type: :integer },
                  seats: { type: :integer }
                }
              },
              images: {
                type: :array,
                properties: {
                  image_url: { type: :string }
                }
              }
            }
          }
        }

        let(:user) { create(:user) }
        let(:Authorization) { "Bearer #{create(:access_token, resource_owner_id: user.id, scopes: 'customer').token}" }
        let(:restaurant) { create(:restaurant) }
        run_test!
      end
    end
  end
end
