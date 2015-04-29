module Fixtures
  module_function

  def request(attrs = {})
    @request ||= Kwipper::Request.new do |r|
      r.http_method = attrs.fetch :method, 'GET'
      r.path      = attrs.fetch :path, '/'
      r.query     = attrs.fetch :query, {}
      r.headers   = attrs.fetch :headers, request_headers
      r.post_data = attrs.fetch :post_data, {}
    end
  end

  def request_headers
    @request_headers ||= Kwipper::RequestHeaders.new.tap do |r|
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