module Fixtures
  module_function

  # The values listed here are required and normally assigned by the http_parser
  def request(attrs = {})
    Kwipper::Request.new do |r|
      r.http_method    = attrs.fetch :method, 'GET'
      r.path           = attrs.fetch :path, '/test'
      r.query          = attrs.fetch :query, query: :hash
      r.headers        = attrs.fetch :headers, request_headers
      r.cookies        = attrs.fetch :cookies, r.headers.cookies
      r.content_length = attrs.fetch :content_length, r.headers.content_length
      r.post_data      = attrs.fetch :post_data, post_data: :hash
    end
  end

  def request_headers
    Kwipper::RequestHeaders.new.tap do |r|
      r["HOST"] ="localhost"
      r["CONNECTION"] = "keep-alive"
      r["CACHE_CONTROL"] = "max-age=0"
      r["ACCEPT"] = "text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8"
      r["USER_AGENT"] = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_3) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/42.0.2311.90 Safari/537.36"
      r["ACCEPT_ENCODING"] = "gzip, deflate, sdch"
      r["ACCEPT_LANGUAGE"] = "en-US,en;q=0.8"
      r["COOKIE"] = ""
    end
  end
end