module Kwipper
  class Application
    include ActionResponders
    include ViewRenderer
    include ViewHelpers

    attr_reader :status_code, :status_message, :body, :request

    def respond_to(request)
      begin
        set_status :ok
        process! request
      rescue NotFoundError => e
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
        raise NotFoundError
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
      end
    end

    def headers_for_response
      headers.map { |k, v| "#{k}: #{v}" }.join "\r\n"
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
  end

  NotFoundError = Class.new RuntimeError
end