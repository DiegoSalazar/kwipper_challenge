module Kwipper
  class TestController < Controller
    add_routes "GET /test/raise_error" => :raise_error,
               "GET /test/response_body" => :response_body

    def raise_error
      raise "error"
    end

    def response_body
      "Success!"
    end
  end
end