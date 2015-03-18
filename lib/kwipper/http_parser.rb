module Kwipper
  class HttpParser
    HEADER_DELIMITER = "\r\n"

    def parse(raw_request)
      @first_line = raw_request.gets

      if @first_line.nil?
        raise Kwipper::EmptyRequest, 'could not get first line'
      else
        Request.new do |r|
          r.http_method = @first_line.split(' ').first
          r.path      = parse_path
          r.query     = parse_query
          r.headers   = parse_headers raw_request
          r.post_data = parse_query_string raw_request.read(r.content_length) if r.post_data?
        end
      end
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

    def parse_headers(raw_request)
      lines = []

      while (line = raw_request.gets) != HEADER_DELIMITER
        lines << line.chomp
      end

      lines.each_with_object RequestHeaders.new do |line, request_headers|
        key, val = line.split(/:\s?/)
        request_headers[key] = val
      end
    end

    def parse_query_string(s)
      Rack::Utils.parse_nested_query s.to_s
    end
  end
end