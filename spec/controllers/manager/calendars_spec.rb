# frozen_string_literal: true

require 'rails_helper'

describe 'Calendars', type: :request do
  context 'authorized admin' do
    let(:user)        { FactoryBot.create(:user, role: 2) }
    let(:token)       { FactoryBot.create(:access_token, resource_owner_id: user.id, scopes: 'manager') }
    let(:restaurant)  { FactoryBot.create(:restaurant) }
    let(:calendar)    { FactoryBot.create(:calendar, restaurant_id: restaurant.id) }

    describe 'create path' do
      before(:each) do
        @params = { data: { date: '01/09/2022' } }
        @headers = { 'Authorization': "Bearer #{token.token}" }
      end

      it 'respond with http created status' do
        post "/manager/restaurants/#{restaurant.id}/calendars", params: @params, headers: @headers
        expect(response).to have_http_status(:created)
      end

      it 'respond with the created calendar' do
        expect do
          post "/manager/restaurants/#{restaurant.id}/calendars", params: @params,
                                                                  headers: @headers
        end.to change(Calendar, :count).by(1)

        created_calendar = JSON.parse(response.body)['data']

        expect(created_calendar['id']).not_to be_nil
        expect(created_calendar['date']).to eq(@params[:data][:date].to_date.strftime('%Y-%m-%d'))
      end
    end

    describe 'update path' do
      before(:each) do
        @params = { data: { reason: 'holiday' } }
        @headers = { 'Authorization': "Bearer #{token.token}" }
      end

      it 'respond with http ok status' do
        patch "/manager/restaurants/#{restaurant.id}/calendars/#{calendar.id}", params: @params, headers: @headers
        expect(response).to have_http_status(:ok)
      end

      it 'respond with the updated calendar' do
        patch "/manager/restaurants/#{restaurant.id}/calendars/#{calendar.id}", params: @params, headers: @headers

        updated_calendar = JSON.parse(response.body)['data']

        expect(updated_calendar['reason']).to eql(@params[:data][:reason])
      end
    end

    describe 'delete path' do
      before(:each) do
        @calendar = restaurant.calendars.create(date: '01/01/2022')
        @headers = { 'Authorization': "Bearer #{token.token}" }
      end

      it 'returns empty body' do
        delete "/manager/restaurants/#{restaurant.id}/calendars/#{calendar.id}", params: {}, headers: @headers
        expect(response.body).to be_empty
      end

      it 'deletes the requested table' do
        expect do
          delete "/manager/restaurants/#{restaurant.id}/calendars/#{@calendar.id}", params: {},
                                                                                    headers: @headers
        end.to change(Calendar, :count).by(-1)
      end
    end
  end
end
