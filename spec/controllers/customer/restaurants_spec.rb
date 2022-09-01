# frozen_string_literal: true

require 'rails_helper'

describe 'Restaurants', type: :request do
  context 'authorized customer' do
    let(:user)        { FactoryBot.create(:user) }
    let(:token)       { FactoryBot.create(:access_token, resource_owner_id: user.id, scopes: 'customer') }

    describe 'index path' do
      it 'respond with http success status code' do
        get '/customer/restaurants', headers: { "Authorization": "Bearer #{token.token}" }
        expect(response).to have_http_status(:ok)
      end
    end
  end
end
