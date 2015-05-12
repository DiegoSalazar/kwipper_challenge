module Kwipper
  class TutorialsController < Controller
    layout "tutorials/layout"
    add_routes "GET /tutorials" => :index,
               "GET /tutorials/:slug" => :show

    def index
      render "tutorials/index"
    end

    def show
      @page = Page.find params["slug"]
    end
  end
end