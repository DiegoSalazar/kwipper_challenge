module Kwipper
  class Request
    attr_accessor :http_method, :path, :query, :headers, :post_data
    attr_reader :params, :cookies

    def initialize
      @post_data = {}
      yield self
    end

    def info
      "#{http_method} #{path}"
    end

    def route_key
      [http_method.to_sym, path]
    end

    def params
      @params ||= query.merge post_data
    end

    def cookies
      headers.cookies
    end

    def content_length
      headers.content_length
    end

    def post_data?
      http_method == 'POST' && headers.has_content?
    end
  end
end