module Kwipper
  class Response
    def initialize(request, application)
      @request, @application = request, application
    end

    def to_http_response
      response = @application.respond_to @request

      <<-HTTP
HTTP/1.1 #{response.status_code} #{response.status_message}
Content-Length: #{response.size}
Content-Type: #{response.content_type}

#{response.body}
      HTTP
    end
  end
end