require 'active_record'
require_relative '../models/product'

class ProductCreationService
  def initialize()
    @delay = (ENV['DELAY'] || 5).to_i
  end

  def create(name)
    Product.create(name: name, status: 'pending', created_at: Time.now)
  end

  def process_pending
    threshold = Time.now - @delay
    Product.where(status: 'pending')
           .where('created_at <= ?', threshold)
           .update_all(status: 'available')
  end

  def start
    Thread.new do
      loop do
        process_pending
        sleep 5
      end
    end
  end
end
