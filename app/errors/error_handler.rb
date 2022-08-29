# frozen_string_literal: true

# Error Handler for Custom Errors on API
module ErrorHandler
  extend ActiveSupport::Concern

  included do
    rescue_from StandardError, with: :server_error
    rescue_from CustomError, with: :custom_error
  end

  def server_error(exception)
    render_json_error([{ field_name: 'base', message: exception.message }], :bad_request)
  end

  def custom_error(exception)
    render_json_error(errors_array(exception.errors.merge(exception.field_name => exception.message)), exception.status)
  end

  def render_json_error(errors, status)
    render json: { errors: errors }, status: status
  end

  def errors_array(errors)
    err_arr = []
    errors.each do |field, messages|
      messages = [messages].flatten
      messages.each do |message|
        json = { field_name: field, message: message }
        err_arr << json
      end
    end
    err_arr
  end
end
