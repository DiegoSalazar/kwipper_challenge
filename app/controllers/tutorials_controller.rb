module Kwipper
  class TutorialsController < Controller
    layout "shared/layout_wide"
    add_routes "GET /tutorials/:slug" => :show

    def show
      @pages = PageDecorator.wrap Page.parents
      @page = PageDecorator.new Page.find_by_slug(params["slug"])

      title @page.header_title

      if @page
        render "tutorials/show"
      else
        @flash = { danger: "Page \"%s\" not found" % params["slug"] }
        render "tutorials/index"
      end
    end
  end
end
