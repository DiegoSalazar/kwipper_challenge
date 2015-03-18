module Kwipper
  class Application
    include Controllers
    include SessionHelpers
    include ViewRenderer
    include ViewHelpers

    attr_reader :request, :response, :action

    def respond_to(request)
      @request = request
      @response = Response.new session_header

      begin
        start_time = Time.now.to_f

        response.set_status :ok
        process! request, response

        log.debug "Processed #{request.info} in #{sprintf '%.8f', Time.now.to_f - start_time}s".blue
      rescue Kwipper::NotFoundError
        render_not_found
        log.warn response.info.yellow
      rescue => e
        render_error e
        log.fatal response.info.red
      end
      response
    end

    def process!(request, response)
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

    def render_not_found
      response.set_status :not_found
      @view = render :not_found
      response.body = render :layout
    end

    def render_error(e)
      @error = e
      response.set_status :server_error
      @view = render :server_error
      response.body = render :layout
    end
  end
end