module Kwipper
  module ControllerHelpers
    protected
    
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