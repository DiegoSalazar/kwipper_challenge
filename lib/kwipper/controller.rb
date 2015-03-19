module Kwipper
  class Controller
    include RendersViews
    include ControllerHelpers

    ROUTES = {
      [:GET, '/'] => [self, 'home']
    }

    def self.add_routes(actions, routes)
      routes = routes.each_with_object({}) do |(route_key, action), r|
        r[route_key] = [self, action]
      end
      ROUTES.merge! routes
    end

    attr_reader :app, :request, :response, :action

    def initialize(app, request, response)
      @app, @request, @response = app, request, response
    end

    def process(action)
      send @action = action
    end

    def home
      render :home
    end

    protected

    def require_login!
      raise Kwipper::AuthenticationRequired unless current_session
    end
  end
end