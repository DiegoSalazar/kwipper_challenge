module Kwipper
  class Request
    attr_accessor :http_method, :path, :query, :headers, :post_data
    attr_accessor :content_length, :cookies, :has_post_data

    def initialize
      @post_data, @headers = {}, {}
      yield self if block_given?
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
      @cookies ||= begin
        c = @headers['COOKIE'].to_s.split(/;\s?/)
        Hash[c.map { |c| c.split '=' }]
      end
    end

    def content_length
      @headers['CONTENT_LENGTH'].to_i
    end
  end
end
