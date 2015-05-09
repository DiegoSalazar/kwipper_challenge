module Kwipper
  class TutorialsController < Controller
    add_routes({
      "GET /tutorials" => :index,
      "GET /tutorials/writing-an-http-server" => :static,
      "GET /tutorials/writing-an-app-framework" => :static,
      "GET /tutorials/implementing-app-features" => :static
    })
    layout "tutorials/layout"

    def index
      render "tutorials/index"
    end
  end
end