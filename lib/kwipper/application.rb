module Kwipper
  class Application
    include ActionResponders
    include ViewRenderer
    include ViewHelpers

    attr_reader :status_code, :status_message, :body, :request

    def respond_to(request)
      begin
        @body = process! request
        set_status :ok
      rescue NotFoundError => e
        set_status :not_found
        # TODO: respond with 404 page
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
      @action = ROUTES[@request.route_key] || raise(NotFoundError)
      @view = send @action
      render :layout
    end

    def content_type
      'text/html'
    end

    def size
      @body.size
    end

    def response_info
      "#{status_code} #{status_message}\n#{body}\n"
    end

    private

    STATUSES = {
      ok: [200, 'OK'],
      not_found: [404, 'Not Found'],
      server_error: [500, 'Server Error']
    }

    def set_status(status)
      @status_code, @status_message = STATUSES[status]
    end
  end

  NotFoundError = Class.new RuntimeError
end