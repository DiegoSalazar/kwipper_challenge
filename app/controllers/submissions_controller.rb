module Kwipper
  class SubmissionsController < Controller
    add_routes "GET /submissions" => :index

    def index
      require_login!
      render "submissions/index"
    end
  end
end