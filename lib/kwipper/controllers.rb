module Kwipper
  module Controllers
    ROUTES = {
      [:GET, '/'] => 'home'
    }

    def home
      render :home
    end

    def self.included(base)
      base.extend ClassMethods

      controller_mods = File.join Kwipper::ROOT, 'app/controllers/**/*.rb'
      Dir[controller_mods].each do |controller_mod|
        require controller_mod
      end
    end

    module ClassMethods
      def add_routes(actions, routes)
        ROUTES.merge! routes
        send :include, actions
      end
    end
  end
end