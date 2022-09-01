# frozen_string_literal: true

require 'rails_helper'

describe 'Reservations', type: :request do
  context 'authorized manager' do
    let(:user)        { FactoryBot.create(:user) }
    let(:token)       { FactoryBot.create(:access_token, resource_owner_id: user.id, scopes: 'manager') }
    let(:restaurant)  { FactoryBot.create(:restaurant) }
    let(:table)       { FactoryBot.create(:table, restaurant_id: restaurant.id) }
    let(:reservation) { FactoryBot.create(:reservation, table_id: table.id, customer_code: '123456789') }

    describe 'show path' do
      before(:each) do
        @headers = { 'Authorization': "Bearer #{token.token}" }
      end
      it 'respond with http ok status' do
        get "/manager/reservations/#{reservation.customer_code}", params: {}, headers: @headers
        expect(response).to have_http_status(:ok)
      end
    end

    describe 'update path' do
      before(:each) do
        @headers = { 'Authorization': "Bearer #{token.token}" }
      end

      it 'respond with http ok status' do
        patch "/manager/reservations/#{reservation.customer_code}", params: @params, headers: @headers
        expect(response).to have_http_status(:ok)
      end

      it 'respond with the updated reservation' do
        patch "/manager/reservations/#{reservation.customer_code}", params: @params, headers: @headers

        updated_reservation = JSON.parse(response.body)['data']

        expect(updated_reservation['status']).to eq('occupied')
      end
    end

    describe 'delete path' do
      before(:each) do
        @reservation = Reservation.create(table_id: table.id, datetime: '30/08/2022-16:00',
                                          customer_code: '0987654321')
        @headers = { 'Authorization': "Bearer #{token.token}" }
      end

      it 'returns empty body' do
        delete "/manager/reservations/#{@reservation.customer_code}", params: {}, headers: @headers
        expect(response.body).to be_empty
      end

      it 'deletes the requested table' do
        expect do
          delete "/manager/reservations/#{@reservation.customer_code}", params: {},
                                                                        headers: @headers
        end.to change(Reservation, :count).by(-1)
      end
    end
  end
end
