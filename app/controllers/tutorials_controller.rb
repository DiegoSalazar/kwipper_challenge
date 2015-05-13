module Kwipper
  class TutorialsController < Controller
    layout "shared/layout_wide"
    add_routes "GET /tutorials" => :index,
               "GET /tutorials/:slug" => :show

    def index
      @pages = PageDecorator.wrap Page.parents
      render "tutorials/index"  
    end

    def show
      @pages = PageDecorator.wrap Page.parents
      page = Page.find_by_slug(params["slug"])

      if page
        CGI.unescapeHTML page.body
      else
        @flash = { danger: "Page \"#{params["slug"]}\" not found" }
        render "tutorials/index"
      end
    end
  end
end
