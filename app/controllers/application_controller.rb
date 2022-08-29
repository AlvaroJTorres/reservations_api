# frozen_string_literal: true

# Methods for all controllers
class ApplicationController < ActionController::API
  include ErrorHandler

  def doorkeeper_unauthorized_render_options(*)
    { json: { errors: ['Not authorized'] } }
  end

  def doorkeeper_forbidden_render_options(*)
    { json: { errors: ['Not authorized'] } }
  end

  def current_user
    @current_user = doorkeeper_authenticate || render_unauthorized
  end

  private

  def render_unauthorized(message = 'Access denied')
    errors = { errors: [message] }
    render json: errors, status: :unauthorized
  end

  def doorkeeper_authenticate
    User.find_by(id: doorkeeper_token[:resource_owner_id])
  end
end
