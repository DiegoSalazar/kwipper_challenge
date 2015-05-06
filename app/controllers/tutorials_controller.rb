module Kwipper
  class TutorialsController < Controller
    add_routes "GET /tutorials" => :index

    def index
      render "tutorials/index"
    end
  end
end