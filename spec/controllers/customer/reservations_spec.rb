# frozen_string_literal: true

require 'rails_helper'

describe 'Reservations', type: :request do
  context 'authorized customer' do
    let(:user)        { FactoryBot.create(:user) }
    let(:token)       { FactoryBot.create(:access_token, resource_owner_id: user.id, scopes: 'customer') }
    let(:restaurant)  do
      FactoryBot.create(:restaurant) do |restaurant|
        FactoryBot.create(:table, restaurant_id: restaurant.id)
        FactoryBot.create(:calendar, restaurant_id: restaurant.id)
        FactoryBot.create(:office_hour, day: 'thursday', restaurant_id: restaurant.id)
      end
    end

    describe 'create path' do
      before(:each) do
        @params = { data: { table_id: restaurant.tables.first.id, datetime: '01/09/2022-16:00' } }
        @headers = { 'Authorization': "Bearer #{token.token}" }
      end

      it 'respond with http created status' do
        post '/customer/reservations', params: @params, headers: @headers
        expect(response).to have_http_status(:created)
      end

      it 'respond with the created reservation' do
        expect do
          post '/customer/reservations', params: @params, headers: @headers
        end.to change(Reservation, :count).by(1)

        created_calendar = JSON.parse(response.body)['data']

        expect(created_calendar['id']).not_to be_nil
        expect(created_calendar['table_id']).to eq(@params[:data][:table_id])
        expect(created_calendar['datetime'].to_datetime).to eq(@params[:data][:datetime].to_datetime)
      end
    end
  end
end
