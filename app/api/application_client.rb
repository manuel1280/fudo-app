require 'json'

class ApplicationClient
  def initialize
    @content_type = 'application/json'
  end

  def parse_request_body(req)
    JSON.parse(req.body.read)
  rescue JSON::ParserError
    nil
  end
end 