module Kwipper
  class SubmissionsController < Controller
    add_routes "GET /submissions" => :index

    def index
      render "submissions/index"
    end
  end
end