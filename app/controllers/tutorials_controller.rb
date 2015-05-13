module Kwipper
  class TutorialsController < Controller
    layout "shared/layout_wide"
    add_routes "GET /tutorials/:slug" => :show

    def show
      @pages = PageDecorator.wrap Page.parents
      @page = Page.find_by_slug params["slug"]

      if @page
        render "tutorials/show"
      else
        @flash = { danger: "Page \"#{params["slug"]}\" not found" }
        render "tutorials/index"
      end
    end
  end
end
