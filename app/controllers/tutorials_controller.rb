module Kwipper
  class TutorialsController < Controller
    add_routes({
      "GET /tutorials" => :index,
      "GET /tutorials/:slug" => :show,
    })
    layout "tutorials/layout"

    def index
      render "tutorials/index"
    end

    def show
      @page = Page.find params["slug"]
    end
  end
end