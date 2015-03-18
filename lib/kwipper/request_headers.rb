module Kwipper
  class RequestHeaders
    def initialize
      @headers = {}
    end

    def []=(name, val)
      @headers[name] = val
    end

    def [](name)
      @headers[name]
    end

    def content_length
      @headers['CONTENT_LENGTH'].to_i
    end

    def has_content?
      content_length > 0
    end
  end
end