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

        log.info "#{"Processed #{request.info}".blue} in #{sprintf '%.8f', Time.now.to_f - start_time}s"
      rescue Kwipper::AuthenticationRequired
        log.debug "401 Not Authorized".yellow
        redirect ?/, :unauthorized
      rescue => e
        log.fatal "#{@response.info.red}\n#{verbose_error(e)}"
        render_error e
      end
      @response
    end

    private

    def process!
      if Controller::ROUTES.key? request.info
        controller_class, @action = Controller::ROUTES[request.info]
        controller = controller_class.new request, response

        response.body = controller.process @action
        
      elsif (file_name = get_file_name)
        response.content_type = get_content_type file_name
        response.body = File.read file_name
      else
        log.warn @response.info.yellow
        render_not_found
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
        "text/plain"
      end
    end

    def render_not_found
      response.set_status :not_found
      response.status_message = "#{response.status_message}: #{request.info}"
      @view = render :not_found
      response.body = render "shared/layout"
    end

    def render_error(e)
      @error = e
      response.set_status :server_error
      @view = render :server_error
      response.body = render "shared/layout"
    end

    def verbose_error(e)
      "#{e.class} #{e.message}\n#{e.backtrace.join "\n"}".red
    end
  end
end
