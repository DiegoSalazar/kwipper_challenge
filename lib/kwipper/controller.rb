module Kwipper
  class Controller
    include RendersViews
    include ControllerHelpers

    ROUTES = {
      "GET /" => [self, :home]
    }

    class << self
      def add_routes(routes)
        routes.each do |info, action|
          ROUTES.merge! info => [self, action]
        end
      end

      def layout(name = "shared/layout")
        @layout ||= name
      end
    end

    attr_reader :request, :response, :action

    def initialize(request, response)
      @request, @response = request, response
    end

    def process(action)
      @view = send @action = action
      render self.class.layout
    end

    def home
      render :home
    end

    def static
      render @request.path
    end

    protected

    def require_login!
      raise Kwipper::AuthenticationRequired unless current_user
    end
  end
end