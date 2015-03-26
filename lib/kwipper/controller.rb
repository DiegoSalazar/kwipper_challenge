module Kwipper
  class Controller
    include RendersViews
    include ControllerHelpers

    ROUTES = {
      [:GET, '/'] => [self, :home]
    }

    def self.add_routes(routes)
      routes.each do |route_key, action|
        ROUTES.merge! route_key => [self, action]
      end
    end

    attr_reader :app, :request, :response, :action

    def initialize(request, response)
      @request, @response = request, response
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