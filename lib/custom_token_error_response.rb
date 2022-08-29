# frozen_string_literal: true

# lib/custom_token_error_response.rb
module CustomTokenErrorResponse
  def body
    {
      errors: [{
        field_name: 'base',
        message: name
      }]
    }
    # or merge with existing values by
    # super.merge({key: value})
  end

  def status
    :unauthorized
  end
end
