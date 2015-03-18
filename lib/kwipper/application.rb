module Kwipper
  class Application
    USER_COOKIE_NAME = 'kwipper_user'
    SESSION_COOKIE_NAME = 'kwipper_session'

    include Controllers
    include ViewRenderer
    include ViewHelpers

    attr_reader :status_code, :status_message, :body, :request

    def initialize
      Dir[File.join(Kwipper::ROOT, 'app/models/**/*.rb')].each do |model|
        require model
      end
    end

    def respond_to(request)
      begin
        set_status :ok
        start_time = Time.now.to_f
        process! request
        log.debug "Processed #{@request.info} in #{sprintf '%2.f', Time.now.to_f - start_time}s"
      rescue Kwipper::NotFoundError => e
        set_status :not_found
        @status_message = "#{@status_message} #{@request.info}"
        @body = '404 Not Found'
        log.warn response_info
      rescue => e
        set_status :server_error
        @body = [e.class, e.message, *e.backtrace].join("\n") + "\n"
        log.fatal response_info
      end
      self
    end

    def process!(request)
      @request = request

      if (@action = ROUTES[@request.route_key])
        @content_type = 'text/html'
        @view = send @action
        @body = render :layout
      elsif (file = public_file_request?)
        @content_type = get_content_type file
        @body = File.read file
      else
        raise Kwipper::NotFoundError
      end
    end

    def response_info
      "#{status_code} #{status_message}"
    end

    def headers
      {
        'Content-Length' => @body.size,
        'Content-Type' => @content_type
      }.tap do |h|
        h['Location'] = @redirect if @redirect
        h['Set-Cookie'] = session_cookie unless session_established?
      end
    end

    def headers_for_response
      headers.map { |k, v| "#{k}: #{v}" }.join "\r\n"
    end

    def params
      @request.params
    end

    def redirect(path, status = :moved)
      @redirect = path
      set_status status
    end

    private

    STATUSES = {
      ok:           [200, 'OK'],
      created:      [201, 'Created'],
      moved:        [301, 'Moved'],
      bad_request:  [400, 'Bad Request'],
      not_found:    [404, 'Not Found'],
      server_error: [500, 'Server Error']
    }

    def set_status(status)
      @status_code, @status_message = STATUSES[status]
    end

    def public_file_request?
      file = File.join(Kwipper::ROOT, 'public', @request.path)
      File.exists?(file) && file
    end

    def get_content_type(file_name)
      if (mime = MIME::Types.of(file_name).first)
        mime.content_type
      else
        log.warn "Unknown content type for file: #{file_name}"
        'text/plain'
      end
    end

    def session_established?
      @request.cookies.key? SESSION_COOKIE_NAME
    end

    def session_cookie
      "#{SESSION_COOKIE_NAME}=#{SecureRandom.urlsafe_base64}; HttpOnly"
    end
  end
end