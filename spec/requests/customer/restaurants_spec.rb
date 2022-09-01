# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe 'customer/restaurants', type: :request do
  path '/customer/restaurants' do
    get('list restaurants') do
      tags 'Restaurants'
      parameter name: 'Authorization', in: :header, type: :string, default: 'Bearer '
      response '200', :success do
        schema type: :object,
               properties:
        {
          data: {
            type: :object,
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
        run_test!
      end
    end
  end
end
