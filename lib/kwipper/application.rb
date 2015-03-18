module Kwipper
  class Application
    include Controllers
    include ViewRenderer
    include ViewHelpers

    attr_reader :request, :response, :action

    def respond_to(request, response)
      begin
        start_time = Time.now.to_f

        response.set_status :ok
        process! request, response

        log.debug "Processed #{request.info} in #{sprintf '%.8f', Time.now.to_f - start_time}s"
      rescue Kwipper::NotFoundError => e
        response.set_status :not_found
        response.status_message = "#{response.status_message} #{request.info}"
        response.body = '404 Not Found'

        log.warn response.info
      rescue => e
        response.set_status :server_error
        response.body = [e.class, e.message, *e.backtrace].join("\n") + "\n"

        log.fatal response.info
      end
      response
    end

    def process!(request, response)
      @request, @response = request, response

      if (@action = ROUTES[request.route_key])
        response.content_type = 'text/html'

        @view = send @action
        response.body = render :layout

      elsif (file_name = public_file_request?)
        response.content_type = get_content_type file_name
        response.body = File.read file_name
      else
        raise Kwipper::NotFoundError
      end
    end

    def params
      request.params
    end

    def redirect(path, status = :moved)
      response.redirect = path
      response.set_status status
    end

    private

    def public_file_request?
      file = File.join(Kwipper::ROOT, 'public', request.path)
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
end