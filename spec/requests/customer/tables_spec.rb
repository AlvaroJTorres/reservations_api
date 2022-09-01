# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe 'customer/tables', type: :request do
  path '/customer/restaurants/{restaurant_id}/tables' do
    get('list tables') do
      tags 'Tables'
      parameter name: 'restaurant_id', in: :path, type: :integer, description: 'restaurant_id'
      security [Bearer: {}]

      response '200', :success do
        schema type: :object,
               properties: {
                 data: {
                   type: :array,
                   properties: {
                     id: { type: :integer },
                     restaurant: { type: :string },
                     seats: { type: :integer },
                     description: { type: :string }
                   }
                 }
               }

        let(:user) { create(:user) }
        let(:restaurant_id) { create(:restaurant).id }
        let(:Authorization) { "Bearer #{create(:access_token, resource_owner_id: user.id, scopes: 'customer').token}" }
        let(:table) { create(:table) }
        run_test!
      end
    end
  end
end
