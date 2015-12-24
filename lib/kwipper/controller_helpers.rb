module Kwipper
  module ControllerHelpers
    protected

    def self.included(base)
      base.class_eval do
        def self.title(title = nil)
          @title = title || @title || Kwipper::APP_TITLE
        end

        def self.layout(name = nil)
          @layout = name || @layout || "shared/layout"
        end
      end
    end

    def title(title = nil)
      self.class.title title
    end

    def layout(name = nil)
      self.class.layout name
    end
    
    def params
      request.params
    end

    def redirect(path, status = :found)
      response.redirect = path
      response.set_status status
    end

    def controller_class
      @controller_class ||= self.class
    end

    def current_user
      response.current_user
    end

    def current_session
      response.current_session
    end

    def current_view?(view)
      @request.path.split(?/).last.match view.to_s
    end

    def render_not_found
      response.set_status :not_found
      response.status_message = "#{response.status_message}: #{request.info}"
      render_response :not_found
    end

    def render_error(e)
      @error = e
      response.set_status :server_error
      render_response :server_error
    end

    def render_access_denied
      @flash = { danger: "Access Denied" }
      response.set_status :unauthorized
      render_response :login_user
    end

    def render_response(view_name, layout = "shared/layout")
      @view = render view_name
      response.body = render layout
    end
  end
end