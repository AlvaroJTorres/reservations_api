# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe 'customer/tables', type: :request do
  path '/customer/restaurants/{restaurant_id}/tables' do
    parameter name: 'restaurant_id', in: :path, type: :string, description: 'restaurant_id'

    get('list tables') do
      tags 'Tables'
      parameter name: 'Authorization', in: :header, type: :string, default: 'Bearer '
      response '200', :success do
        schema type: :object,
               properties: {
                 data: {
                   type: :object,
                   properties: {
                     id: { type: :integer },
                     restaurant_id: { type: :integer },
                     seats: { type: :integer }
                   }
                 }
               }
        run_test!
      end
    end
  end
end
