module Kwipper
  class Application
    include RendersViews
    include ControllerHelpers

    attr_reader :request, :response

    def respond_to(request)
      @request = request
      @response = Response.new request

      begin
        start_time = Time.now.to_f
        process!

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

    def process!
      response.set_status :ok
      controller_class, action = Controller::ROUTES[request.route_key]

      if controller_class
        response.content_type = 'text/html'

        controller = controller_class.new self, request, response
        @view = controller.send action

        response.body = render :layout

      elsif (file_name = public_file_request?)
        response.content_type = get_content_type file_name
        response.body = File.read file_name
      else
        raise Kwipper::NotFoundError
      end
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
      response.status_message = "#{response.status_message}: #{request.info}"
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