# frozen_string_literal: true

require 'rails_helper'

describe 'Restaurants', type: :request do
  context 'authorized admin' do
    let(:user)        { FactoryBot.create(:user, role: 1) }
    let(:token)       { FactoryBot.create(:access_token, resource_owner_id: user.id, scopes: 'admin') }
    let(:restaurant)  { FactoryBot.create(:restaurant) }

    describe 'create path' do
      before(:each) do
        @params = { data: { name: 'Test Restaurant', address: 'Test address' } }
        @headers = { 'Authorization': "Bearer #{token.token}" }
      end

      it 'respond with http created status' do
        post '/admin/restaurants', params: @params, headers: @headers
        expect(response).to have_http_status(:created)
      end

      it 'respond with the created restaurant' do
        expect { post '/admin/restaurants', params: @params, headers: @headers }.to change(Restaurant, :count).by(1)

        created_restaurant = JSON.parse(response.body)['data']

        expect(created_restaurant['id']).not_to be_nil
        expect(created_restaurant['name']).to eq(@params[:data][:name])
        expect(created_restaurant['address']).to eq(@params[:data][:address])
      end
    end

    describe 'update path' do
      before(:each) do
        @params = { data: { name: 'Updated Restaurant' } }
        @headers = { 'Authorization': "Bearer #{token.token}" }
      end

      it 'respond with http ok status' do
        patch "/admin/restaurants/#{restaurant.id}", params: @params, headers: @headers
        expect(response).to have_http_status(:ok)
      end

      it 'respond with the updated restaurant' do
        patch "/admin/restaurants/#{restaurant.id}", params: @params, headers: @headers

        updated_restaurant = JSON.parse(response.body)['data']

        expect(updated_restaurant['name']).to eql(@params[:data][:name])
      end
    end

    describe 'delete path' do
      before(:each) do
        @headers = { 'Authorization': "Bearer #{token.token}" }
      end

      it 'returns empty body' do
        delete "/admin/restaurants/#{restaurant.id}", params: {}, headers: @headers
        expect(response.body).to be_empty
      end

      it 'soft deletes the requested restaurant' do
        delete "/admin/restaurants/#{restaurant.id}", params: {}, headers: @headers

        deleted_restaurant = Restaurant.find(restaurant.id)

        expect(deleted_restaurant.deleted_at).not_to be_nil
      end
    end
  end
end
