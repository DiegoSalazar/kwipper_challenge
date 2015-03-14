module Kwipper
  class Application
    attr_reader :status_code, :status_message, :body
    include ActionResponders

    def respond_to(request)
      @request = request
      @body = ''

      @action = ROUTES[
        [@request.request_method.to_sym, @request.path]
      ] || raise(NotFoundError)

      @body = send @action

      set_ok_response
      self
    rescue NotFoundError => e
      set_not_found_response
      log.warn response_info
      self
    rescue => e
      set_error_response
      @body = e.message + "\n"
      log.fatal response_info
      self
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

    def set_ok_response
      @status_code = 200
      @status_message = 'OK'
    end

    def set_not_found_response
      @status_code = 404
      @status_message = 'Not Found'
    end

    def set_error_response
      @status_code = 500
      @status_message = 'Server Error'
    end
  end

  NotFoundError = Class.new RuntimeError
end