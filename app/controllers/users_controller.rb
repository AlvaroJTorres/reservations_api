# frozen_string_literal: true

# Controllers for User Model
# class UsersController < ApplicationController
#   before_action -> { doorkeeper_authorize! :admin }

#   def index
#     result = Operations::UserOperations::Index.call(params: {})
#     render json: { data: { users: result[:model] } }
#   end

#   def create
#     result = Operations::UserOperations::Create.call(params: user_params)
#     render json: { data: { user: result[:model] } }, status: :created
#   end

#   def update
#     result = Operations::UserOperations::Update.call(params: user_params, id: params[:id])
#     render json: { data: { user: result[:model] } }
#   end

#   private

#   def user_params
#     params.require(:data).permit(:name, :email, :role, :avatar, :restaurant_id)
#   end
# end
