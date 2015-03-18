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
    SESSION_COOKIE_NAME = 'kwipper_session'

    attr_accessor :status_code, :status_message, :content_type, :redirect, :body
    attr_reader :request, :headers

    def initialize(request)
      @request = request
      @headers = session_header
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

    def headers_for_response
      headers.merge({
        'Content-Length' => body.size,
        'Content-Type' => content_type
      }).tap do |h|
        h['Location'] = redirect if redirect
      end.map { |k, v| "#{k}: #{v}" }.join "\r\n"
    end

    def set_status(status)
      @status_code, @status_message = STATUSES[status]
    end

    # Session helpers

    def session_header
      {}.tap { |h| h['Set-Cookie'] = session_cookie unless has_session? }
    end

    def has_session?
      request.cookies.key? SESSION_COOKIE_NAME
    end

    def session_cookie
      "#{SESSION_COOKIE_NAME}=#{session_cookie_value}; HttpOnly"
    end

    def session_cookie_value
      @session_cookie_value ||= request.cookies.fetch SESSION_COOKIE_NAME, SecureRandom.urlsafe_base64
    end

    def current_user
      if current_session
        @current_user ||= User.find current_session.user_id
      end
    end

    def current_session
      if has_session?
        @current_session ||= Session.find request.cookies[SESSION_COOKIE_NAME]
      end
    end
  end
end