# frozen_string_literal: true

require 'rails_helper'

describe 'Tables', type: :request do
  context 'authorized manager' do
    let(:user)        { FactoryBot.create(:user, role: 2) }
    let(:token)       { FactoryBot.create(:access_token, resource_owner_id: user.id, scopes: 'manager') }
    let(:restaurant)  { FactoryBot.create(:restaurant) }
    let(:table)       { FactoryBot.create(:table, restaurant_id: restaurant.id) }

    describe 'create path' do
      before(:each) do
        @params = { data: { seats: 2, description: 'Test table' } }
        @headers = { 'Authorization': "Bearer #{token.token}" }
      end

      it 'respond with http created status' do
        post "/manager/restaurants/#{restaurant.id}/tables", params: @params, headers: @headers
        expect(response).to have_http_status(:created)
      end

      it 'respond with the created table' do
        expect do
          post "/manager/restaurants/#{restaurant.id}/tables", params: @params,
                                                               headers: @headers
        end.to change(Table, :count).by(1)

        created_table = JSON.parse(response.body)['data']

        expect(created_table['id']).not_to be_nil
        expect(created_table['seats']).to eq(@params[:data][:seats])
        expect(created_table['description']).to eq(@params[:data][:description])
      end
    end

    describe 'delete path' do
      before(:each) do
        @headers = { 'Authorization': "Bearer #{token.token}" }
      end

      it 'returns empty body' do
        delete "/manager/restaurants/#{restaurant.id}/tables/#{table.id}", params: {}, headers: @headers
        expect(response.body).to be_empty
      end

      it 'soft deletes the requested table' do
        delete "/manager/restaurants/#{restaurant.id}/tables/#{table.id}", params: {}, headers: @headers

        deleted_table = Table.find(table.id)

        expect(deleted_table.deleted_at).not_to be_nil
      end
    end
  end
end
