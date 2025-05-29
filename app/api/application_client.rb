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

  def set_json_response(res, data, status: 200)
    res.status = status
    res.headers['Content-Type'] = @content_type
    res.write(data.to_json)
  end

  def set_error_response(res, message, status: 400)
    res.status = status
    res.headers['Content-Type'] = @content_type
    res.write({ error: message }.to_json)
  end

  def unauthorized_response(res)
    set_error_response(res, 'Unauthorized', status: 401)
  end

  def not_found_response(res)
    set_error_response(res, 'Not Found', status: 404)
  end

  def send_public_file(file_name, res, cache: true)
    file_path = File.expand_path("../../../public/#{file_name}", __FILE__)

    if File.exist?(file_path)
      res.headers['Cache-Control'] = cache ? 'public, max-age=31536000' : 'no-cache'
      res.write(File.read(file_path))
    else
      not_found_response(res)
    end
  end
end