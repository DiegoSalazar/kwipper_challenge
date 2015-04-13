module Kwipper
  class Application
    include RendersViews
    include ControllerHelpers

    attr_reader :request, :response, :action

    def respond_to(request)
      @request = request
      @response = Response.new request

      begin
        start_time = Time.now.to_f
        process!

        log.debug "#{"Processed #{request.info}".blue} in #{sprintf '%.8f', Time.now.to_f - start_time}s"
      rescue Kwipper::AuthenticationRequired
        redirect '/'
        log.debug "401 Not Authorized".yellow
      rescue Kwipper::NotFoundError
        render_not_found
        log.warn @response.info.yellow
      rescue => e
        render_error e
        log.fatal "#{@response.info.red}\n#{verbose_error(e)}"
      end
      @response
    end

    def process!
      if Controller::ROUTES.key? request.route_key
        response.set_status :ok
        response.content_type = 'text/html'

        controller_class, @action = Controller::ROUTES[request.route_key]
        controller = controller_class.new request, response

        if controller.respond_to? @action
          @view = controller.process @action
          response.body = render :layout
        else
          raise Kwipper::NotFoundError, "#{self} does not know #{@action}"
        end
      elsif (file_name = get_file_name)
        response.set_status :ok
        response.content_type = get_content_type file_name
        response.body = File.read file_name
      else
        raise Kwipper::NotFoundError
      end
    end

    private

    def get_file_name
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

    def verbose_error(e)
      "#{e.class} #{e.message}\n#{e.backtrace.join "\n"}".red
    end
  end
end
