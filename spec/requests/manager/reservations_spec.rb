# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe 'manager/reservations', type: :request do
  path '/manager/reservations/{customer_code}' do
    parameter name: 'customer_code', in: :path, type: :string, description: 'customer_code'

    get('show reservation') do
      tags 'Reservations'
      security [Bearer: {}]

      response '401', :unauthorized do
        let(:Authorization) { '' }
        let(:customer_code) { create(:reservation).customer_code }
        run_test!
      end

      response '200', :success do
        schema type: :object,
               properties: {
                 id: { type: :integer },
                 table_id: { type: :integer },
                 restaurant: { type: :string },
                 datetime: { type: :string, format: :datetime },
                 status: { type: :string },
                 customer_code: { type: :string }
               }
        let!(:user) { create(:user, role: 2) }
        let(:Authorization) { "Bearer #{create(:access_token, resource_owner_id: user.id, scopes: 'manager').token}" }
        let(:customer_code) { create(:reservation).customer_code }
        run_test!
      end
    end

    patch('update reservation') do
      tags 'Reservations'
      parameter name: 'Authorization', in: :header, type: :string, default: 'Bearer '

      response '401', :unauthorized do
        let(:Authorization) { '' }
        let(:customer_code) { create(:reservation).customer_code }
        run_test!
      end

      response '200', :success do
        let!(:user) { create(:user, role: 2) }
        let(:Authorization) { "Bearer #{create(:access_token, resource_owner_id: user.id, scopes: 'manager').token}" }
        let(:customer_code) { create(:reservation).customer_code }
        run_test!
      end
    end

    delete('delete reservation') do
      tags 'Reservations'
      parameter name: 'Authorization', in: :header, type: :string, default: 'Bearer '

      response '204', :no_content do
        let!(:user) { create(:user, role: 2) }
        let(:Authorization) { "Bearer #{create(:access_token, resource_owner_id: user.id, scopes: 'manager').token}" }
        let(:customer_code) { create(:reservation).customer_code }
        run_test!
      end

      response '401', :unauthorized do
        let(:Authorization) { '' }
        let(:customer_code) { create(:reservation).customer_code }
        run_test!
      end
    end
  end
end
