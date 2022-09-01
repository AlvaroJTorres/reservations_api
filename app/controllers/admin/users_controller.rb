# frozen_string_literal: true

module Admin
  # Controllers for User Model
  class UsersController < Admin::ApplicationController
    before_action -> { doorkeeper_authorize! :admin }

    def index
      result = Operations::UserOperations::Index.call(params: {}, pagy_call: method(:pagy))
      render json: { data: result[:records] }.merge!(meta: { pagination: pagy_headers_hash(result[:pagy]) }), status: :ok
    end

    def create
      result = Operations::UserOperations::Create.call(params: user_params)
      render json: { data: result[:model] }, status: :created
    end

    def update
      result = Operations::UserOperations::Update.call(params: user_params, id: params[:id])
      render json: { data: result[:model] }
    end

    private

    def user_params
      params.require(:data).permit(:name, :email, :role, :avatar, :restaurant_id)
    end
  end
end
