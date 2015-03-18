module Kwipper
  module Controllers
    ROUTES = {
      [:GET, '/'] => 'home'
    }

    def home
      @users = User.all
      render :home
    end

    def self.included(base)
      Dir[File.join(Kwipper::ROOT, 'app/controllers/**/*.rb')].each do |controller_mod|
        require controller_mod
      end
    end
  end
end