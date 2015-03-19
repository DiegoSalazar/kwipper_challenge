module Kwipper
  class PagesController < Controller
    add_routes self, {
      [:GET, '/about'] => :about
    }

    def about
      render :about_page
    end
  end
end