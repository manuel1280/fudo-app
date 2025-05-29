require_relative 'fudo_app'
use Rack::Deflater
run FudoApp.new 