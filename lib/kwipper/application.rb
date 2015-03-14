module Kwipper
  class Application
    include ActionResponders
    include ViewRenderer

    attr_reader :status_code, :status_message, :body

    def respond_to(request)
      @request = request
      @body = process!
      set_status :ok
      self
    rescue NotFoundError => e
      set_status :not_found
      log.warn response_info
      self
    rescue => e
      set_status :server_error
      @body = [e.class, e.message, *e.backtrace].join("\n") + "\n"
      log.fatal response_info
      self
    end

    def process!
      action = ROUTES[
        [@request.request_method.to_sym, @request.path]
      ] || raise(NotFoundError)

      @view = send action
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