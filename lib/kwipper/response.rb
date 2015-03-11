module Kwipper
  class Response
    def initialize(request, application)
      @request, @application = request, application
    end

    def to_http
      <<-HTTP
Hello
#{@request.inspect}
Goobye
      HTTP
    end
  end
end