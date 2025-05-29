require_relative 'application_client'
require_relative '../models/product'
require_relative '../services/product_creation_service'

class ProductsApi < ApplicationClient
  def initialize
    super
    @product_service = ProductCreationService.new
  end

  def handle_create_product(req, res)
    data = parse_request_body(req)

    unless data&.key?('name')
      return set_error_response(res, 'Missing product name', status: 400)
    end

    begin
      product = @product_service.create(data['name'])

      res.headers['Location'] = "/products/#{product.id}"
      set_json_response(res, { message: 'Product will be created asynchronously', id: product.id }, status: 202)
    rescue StandardError => e
      set_error_response(res, "Failed to create product: #{e.message}", status: 500)
    end
  end

  def handle_list_products(req, res)
    begin
      products = Product.where(status: 'available').as_json(only: [:id, :name, :status])
      set_json_response(res, products)
    rescue StandardError => e
      set_error_response(res, "Failed to retrieve products: #{e.message}", status: 500)
    end
  end
end