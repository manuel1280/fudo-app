require 'active_record'

class Product < ActiveRecord::Base
  validates :name, presence: true
end
