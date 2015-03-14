module Kwipper
  class Request
    def initialize
      @headers = {}
    end

    def []=(name, val)
      @headers[name] = val
    end

    def [](name)
      @headers[name]
    end
  end
end