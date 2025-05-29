require 'json'

require_relative 'app/models/product'
require_relative 'app/models/user_session'
require_relative 'app/db/connection'
require_relative 'app/api/application_client'
require_relative 'app/api/authentication_client'
require_relative 'app/api/products_api'

establish_connection
load File.expand_path('app/db/schema.rb', __dir__)
seed_database

class FudoApp
  def initialize
    @auth_client = AuthenticationClient.new
    @products_api = ProductsApi.new
    @application_client = ApplicationClient.new
    @products_api.start_background_services_queue
  end

  def call(env)
    req = Rack::Request.new(env)
    res = Rack::Response.new

    request_http = [req.request_method, req.path_info].join(' ')

    case request_http
    when 'POST /auth'
      @auth_client.handle_authentication(req, res)
    when 'POST /products'
      handle_create_product(req, res)
    when 'GET /products'
      handle_list_products(req, res)
    when %r{^GET /products/\d+$}
      handle_get_product(req, res)
    when 'GET /AUTHORS'
      @application_client.send_public_file('AUTHORS', res, cache: true)
    when 'GET /'
      @application_client.send_public_file('openapi.yaml', res, cache: false)
    else
      @application_client.not_found_response(res)
    end

    res.finish
  end

  private

  def authenticate_request(req, res)
    return unless @auth_client.require_authentication(req, res)
    yield
  end

  def handle_create_product(req, res)
    authenticate_request(req, res) { @products_api.handle_create_product(req, res) }
  end

  def handle_list_products(req, res)
    authenticate_request(req, res) { @products_api.handle_list_products(req, res) }
  end

  def handle_get_product(req, res)
    authenticate_request(req, res) { @products_api.handle_get_product(req, res) }
  end
end
