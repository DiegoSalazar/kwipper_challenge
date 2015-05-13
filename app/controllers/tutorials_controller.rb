module Kwipper
  class TutorialsController < Controller
    layout "shared/layout_wide"
    add_routes "GET /tutorials" => :index,
               "GET /tutorials/:slug" => :show

    def index
      @pages = Page.all
      render "tutorials/index"  
    end

    def show
      @pages = Page.all
      page = @pages.find { |p| p.slug == params["slug"] }
      page.body
    end
  end
end