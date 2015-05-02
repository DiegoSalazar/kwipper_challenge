module Fixtures
  module_function

  # The values listed here are required and normally assigned by the http_parser
  def request(attrs = {})
    Kwipper::Request.new do |r|
      r.path           = attrs.fetch :path, '/test'
      r.query          = attrs.fetch :query, query: :hash
      r.headers        = attrs.fetch :headers, request_headers
      r.cookies        = attrs.fetch :cookies, r.headers.cookies
      r.post_data      = attrs.fetch :post_data, post_data: :hash
      r.http_method    = attrs.fetch :method, 'GET'
      r.content_length = attrs.fetch :content_length, r.headers.content_length
    end
  end

  def request_headers
    Kwipper::RequestHeaders.new.tap do |r|
      r["HOST"]            = "localhost"
      r["COOKIE"]          = ""
      r["ACCEPT"]          = "text/html"
      r["USER_AGENT"]      = "Mozilla/5.0"
      r["CONNECTION"]      = "keep-alive"
      r["CACHE_CONTROL"]   = "max-age=0"
      r["ACCEPT_ENCODING"] = "gzip, deflate, sdch"
      r["ACCEPT_LANGUAGE"] = "en-US,en;q=0.8"
    end
  end
end
