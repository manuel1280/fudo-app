require 'active_record'
require_relative '../models/product'

class ProductCreationService
  def initialize()
    @delay = (ENV['DELAY'] || 5).to_i
  end

  def create(name)
    Product.create(name: name, status: 'pending', created_at: Time.now)
  end
end
