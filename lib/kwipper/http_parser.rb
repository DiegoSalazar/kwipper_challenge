module Kwipper
  class HttpParser
    HEADER_DELIMITER = "\r\n"
    
    attr_reader :http_method,
      :path,
      :query,
      :headers,
      :post_data,
      :params,
      :cookies

    def parse(raw_request)
      @raw_request = raw_request
      @first_line  = @raw_request.gets

      if @first_line.nil?
        raise Kwipper::EmptyRequest, 'could not get first line'
      else
        @http_method = @first_line.split(' ').first
      end

      @path      = parse_path
      @query     = parse_query
      @headers   = parse_headers
      @post_data = parse_post_data if post_data?
      @params    = @query.merge @post_data || {}
      @cookies   = @headers.cookies
      self
    end

    def info
      "#{http_method} #{path}"
    end

    def route_key
      [@http_method.to_sym, @path]
    end

    private

    def parse_path
      p = @first_line.split(' ')[1]
      p ? p.split('?').first : '/'
    end

    def parse_query
      p = @first_line.split(' ')[1]
      q = p && !p['?'].nil? ? p.split('?').last.chomp : nil
      parse_query_string q
    end

    def parse_headers
      lines = []

      while (line = @raw_request.gets) != HEADER_DELIMITER
        lines << line.chomp
      end

      lines.each_with_object RequestHeaders.new do |line, request_headers|
        key, val = line.split(/:\s?/)
        request_headers[key] = val
      end
    end

    def post_data?
      @http_method == 'POST' && @headers.has_content?
    end

    def parse_post_data
      parse_query_string @raw_request.read(@headers.content_length)
    end

    def parse_query_string(s)
      Rack::Utils.parse_nested_query s.to_s
    end
  end
end