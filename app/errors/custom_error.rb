# frozen_string_literal: true

# Custom Error for API Operations
class CustomError < StandardError
  attr_reader :field_name, :message, :status, :errors

  def initialize(field_name = nil, message = nil, status = nil, errors = nil)
    @field_name = field_name || 'base'
    @message = message || 'Somenthing went wrong'
    @status = status || :unprocessable_entity
    @errors = errors || {}
    super(@message)
  end
end
