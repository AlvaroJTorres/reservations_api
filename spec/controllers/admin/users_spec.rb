# frozen_string_literal: true

require 'rails_helper'

describe 'Users', type: :request do
  context 'authorized admin' do
    let(:user)        { FactoryBot.create(:user, role: 1) }
    let(:manager)     { FactoryBot.create(:user, role: 2) }
    let(:restaurant)  { FactoryBot.create(:restaurant, user_id: manager.id) }
    let(:new_restaurant) { FactoryBot.create(:restaurant) }
    let(:token) { FactoryBot.create(:access_token, resource_owner_id: user.id, scopes: 'admin') }

    describe 'index path' do
      it 'respond with http success status code' do
        get '/admin/users', headers: { "Authorization": "Bearer #{token.token}" }
        expect(response).to have_http_status(:ok)
      end
    end

    describe 'create path' do
      before(:each) do
        @params = { data: { name: 'Test User', email: 'testmail@mail.com', restaurant_id: new_restaurant.id } }
        @headers = { 'Authorization': "Bearer #{token.token}" }
      end

      it 'respond with http created status' do
        post '/admin/users', params: @params, headers: @headers
        expect(response).to have_http_status(:created)
      end

      it 'respond with the created restaurant' do
        expect { post '/admin/users', params: @params, headers: @headers }.to change(User, :count).by(1)

        created_user = JSON.parse(response.body)['data']

        expect(created_user['id']).not_to be_nil
        expect(created_user['name']).to eq(@params[:data][:name])
        expect(created_user['email']).to eq(@params[:data][:email])
      end
    end

    describe 'update path' do
      before(:each) do
        @params = { data: { name: 'Updated User' } }
        @headers = { 'Authorization': "Bearer #{token.token}" }
      end

      it 'respond with http ok status' do
        patch "/admin/users/#{manager.id}", params: @params, headers: @headers
        expect(response).to have_http_status(:ok)
      end

      it 'respond with the updated manager' do
        patch "/admin/users/#{manager.id}", params: @params, headers: @headers

        updated_user = JSON.parse(response.body)['data']

        expect(updated_user['name']).to eql(@params[:data][:name])
      end
    end
  end
end
