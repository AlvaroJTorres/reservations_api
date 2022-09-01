# frozen_string_literal: true

require 'rails_helper'

describe 'Office Hours', type: :request do
  context 'authorized manager' do
    let(:user)        { FactoryBot.create(:user, role: 2) }
    let(:token)       { FactoryBot.create(:access_token, resource_owner_id: user.id, scopes: 'manager') }
    let(:restaurant)  { FactoryBot.create(:restaurant) }
    let(:office_hour) { FactoryBot.create(:office_hour, restaurant_id: restaurant.id) }

    describe 'create path' do
      before(:each) do
        @params = { data: { day: 'tuesday', open: '16:00', close: '21:00' } }
        @headers = { 'Authorization': "Bearer #{token.token}" }
      end

      it 'respond with http created status' do
        post "/manager/restaurants/#{restaurant.id}/office_hours", params: @params, headers: @headers
        expect(response).to have_http_status(:created)
      end

      it 'respond with the created office_hour' do
        expect do
          post "/manager/restaurants/#{restaurant.id}/office_hours", params: @params,
                                                                     headers: @headers
        end.to change(OfficeHour, :count).by(1)

        created_office_hour = JSON.parse(response.body)['data']

        expect(created_office_hour['id']).not_to be_nil
        expect(created_office_hour['day']).to eq(@params[:data][:day])
        expect(created_office_hour['open'].to_time.hour).to eq(@params[:data][:open].to_time.hour)
        expect(created_office_hour['close'].to_time.hour).to eq(@params[:data][:close].to_time.hour)
      end
    end

    describe 'update path' do
      before(:each) do
        @params = { data: { day: 'wednesday' } }
        @headers = { 'Authorization': "Bearer #{token.token}" }
      end

      it 'respond with http ok status' do
        patch "/manager/restaurants/#{restaurant.id}/office_hours/#{office_hour.id}", params: @params,
                                                                                      headers: @headers
        expect(response).to have_http_status(:ok)
      end

      it 'respond with the updated office_hour' do
        patch "/manager/restaurants/#{restaurant.id}/office_hours/#{office_hour.id}", params: @params,
                                                                                      headers: @headers

        updated_office_hour = JSON.parse(response.body)['data']

        expect(updated_office_hour['day']).to eql(@params[:data][:day])
      end
    end

    describe 'delete path' do
      before(:each) do
        @office_hour = restaurant.office_hours.create(day: 3, open: '13:00', close: '14:00')
        @headers = { 'Authorization': "Bearer #{token.token}" }
      end

      it 'returns empty body' do
        delete "/manager/restaurants/#{restaurant.id}/office_hours/#{office_hour.id}", params: {}, headers: @headers
        expect(response.body).to be_empty
      end

      it 'deletes the requested table' do
        expect do
          delete "/manager/restaurants/#{restaurant.id}/office_hours/#{@office_hour.id}", params: {},
                                                                                          headers: @headers
        end.to change(OfficeHour, :count).by(-1)
      end
    end
  end
end
