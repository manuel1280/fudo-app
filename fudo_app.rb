require 'rack'
require 'json'
require 'active_record'
require 'securerandom'
require 'byebug'

class FudoApp
  def initialize

  end

  def call(env)
    req = Rack::Request.new(env)
    res = Rack::Response.new
    res['Content-Type'] = 'application/json'
    res.write(JSON.generate({"greeting": "Hello World!"}))
    res.finish
  end
end