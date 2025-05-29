require_relative 'application_client'
require_relative '../services/auth_service'

class AuthenticationClient < ApplicationClient
  def initialize
    super
    @auth_service = AuthService.new
  end

  def handle_authentication(req, res)
    data = parse_request_body(req)

    unless data&.key?('user') && data&.key?('password')
      return set_error_response(res, 'Missing user or password', status: 400)
    end

    token = @auth_service.authenticate(data['user'], data['password'])

    if token
      set_json_response(res, { token: token })
    else
      set_error_response(res, 'Invalid credentials', status: 401)
    end
  end

  def authorized?(req)
    token = req.env['HTTP_AUTHORIZATION']&.sub('Bearer ', '')
    @auth_service.valid?(token)
  end

  def require_authentication(req, res)
    if authorized?(req)
      true
    else
      unauthorized_response(res)
      false
    end
  end
end 