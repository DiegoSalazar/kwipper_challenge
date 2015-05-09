module Kwipper
  class TestController < Controller
    add_routes({
      "GET /test/raise_error" => :test_raise_error,
      "GET /test/response_body" => :test_response_body
    })

    def test_raise_error
      raise "test error"
    end

    def test_response_body
      "Success!"
    end
  end
end