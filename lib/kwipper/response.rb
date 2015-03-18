module Kwipper
  class Response
    STATUSES = {
      ok:           [200, 'OK'],
      created:      [201, 'Created'],
      moved:        [301, 'Moved'],
      bad_request:  [400, 'Bad Request'],
      not_found:    [404, 'Not Found'],
      server_error: [500, 'Server Error']
    }

    attr_accessor :status_code, :status_message, :content_type, :redirect, :body

    def initialize(headers = {})
      @headers = headers
    end

    def to_http_response
<<-HTTP
HTTP/1.1 #{status_code} #{status_message}
#{headers_for_response}

#{body}
HTTP
    end

    def info
      "#{@status_code} #{@status_message}"
    end

    def headers
      @headers.merge({
        'Content-Length' => body.size,
        'Content-Type' => content_type
      }).tap do |h|
        h['Location'] = redirect if redirect
      end
    end

    def headers_for_response
      headers.map { |k, v| "#{k}: #{v}" }.join "\r\n"
    end

    def set_status(status)
      @status_code, @status_message = STATUSES[status]
    end
  end
end