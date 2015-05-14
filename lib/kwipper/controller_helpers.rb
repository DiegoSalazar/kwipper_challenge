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

    def current_user
      response.current_user
    end

    def current_session
      response.current_session
    end

    def current_view?(view)
      @request.path.split(?/).last.match view.to_s
    end
  end
end