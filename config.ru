require_relative 'fudo_app'
require 'rack'


use Rack::Deflater
run FudoApp.new
