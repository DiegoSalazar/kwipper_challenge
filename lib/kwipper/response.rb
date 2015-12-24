module Kwipper
  class Response
    STATUSES = {
      ok:           [200, "OK"],
      created:      [201, "Created"],
      found:        [302, "Found"],
      bad_request:  [400, "Bad Request"],
      unauthorized: [401, "Unauthorized"],
      not_found:    [404, "Not Found"],
      server_error: [500, "Server Error"]
    }
    SESSION_COOKIE_NAME = "kwipper_session"

    attr_accessor :status_code, :status_message, :content_type, :redirect, :body
    attr_reader :request

    def initialize(request)
      @request = request
      @body = ""
      @status_code, @status_message = STATUSES[:ok]
      @content_type = "text/html"
    end

    def to_http
<<-HTTP
HTTP/1.1 #{status_code} #{status_message}
#{serialize_headers}

#{body}
HTTP
    end

    def info
      "#{@status_code} #{@status_message}"
    end

    def headers
      @headers ||= {}.tap do |h|
        h["Set-Cookie"] = session_cookie unless has_session?
      end
    end

    def set_status(status)
      @status_code, @status_message = STATUSES.fetch status
    end

    def current_user
      @current_user ||= User.find current_session.user_id if current_session
    end

    def current_session
      if has_session?
        @current_session ||= Session.where(session_id: session_cookie_value).first
      end
    end
    
    # For the server to remove a browser cookie we need to set a cookie of the 
    # same name with an expires value to now (or in the past) so that the browser
    # will expire it and remove it. The value is also voided.
    def remove_session_cookie
      headers["Set-Cookie"] = session_cookie "x; expires=#{Time.at(0).httpdate}"
    end

    def session_cookie_value
      @generated_cookie_value ||= SecureRandom.urlsafe_base64
      request.cookies.fetch SESSION_COOKIE_NAME, @generated_cookie_value
    end

    private

    def serialize_headers
      headers.merge({
        "Content-Length" => body.size,
        "Content-Type" => content_type
      }).tap do |h|
        add_location_header h if redirect
      end.map { |k, v| "#{k}: #{v}" }.join "\r\n"
    end

    def has_session?
      request.cookies.key? SESSION_COOKIE_NAME
    end

    def session_cookie(value = "#{session_cookie_value}; HttpOnly")
      "#{SESSION_COOKIE_NAME}=#{value}"
    end

    def add_location_header(headers)
      log.info "Redirecting to #{redirect}".blue
      headers["Location"] = redirect
    end
  end
end