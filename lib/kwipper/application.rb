module Kwipper
  class Application
    include RendersViews
    include ControllerHelpers

    attr_reader :request, :response, :action

    def respond_to(request)
      @request = request
      @response = Response.new request
      @router = Router.new Controller::ROUTES

      begin
        Kwipper.benchmark "Processed #{request.info}".blue do
          process!
        end
      rescue Kwipper::AuthenticationRequired # TODO move this into a filter
        log.debug "401 Not Authorized".yellow
        render_access_denied
      rescue => e
        log.fatal "#{@response.info.red}\n#{verbose_error(e)}"
        render_error e
      end
      @response
    end

    private

    def process!
      if @router.route? request.info
        @controller_class, @action = @router.dispatch
        request.merge_params! @router.segments
        controller = @controller_class.new request, response

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

    def verbose_error(e)
      "#{e.class} #{e.message}\n#{e.backtrace.join "\n"}".red
    end
  end
end
