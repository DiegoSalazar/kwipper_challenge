module Kwipper
  class HttpParser
    HEADER_DELIMITER = "\r\n"
    
    attr_reader :http_method, :path, :query, :headers, :post_data

    def parse(raw_request)
      @raw_request = raw_request
      @first_line  = @raw_request.gets
      @http_method = @first_line.split(' ').first.dup
      @path        = parse_path
      @query       = parse_query
      @request     = parse_request
      @post_data   = parse_post_data if post_data?
      self
    end

    def info
      "#{http_method} #{@path}"
    end

    def route_key
      [http_method.to_sym, path]
    end

    private

    def parse_path
      path = @first_line.split(' ')[1]
      path ? path.split('?').first : '/'
    end

    def parse_query
      path = @first_line.split(' ')[1]
      path && !path['?'].nil? ? path.split('?').last.chomp : nil
    end

    def parse_request
      lines = []

      while (line = @raw_request.gets) != HEADER_DELIMITER
        lines << line.chomp
      end

      lines.each_with_object Request.new do |line, request|
        key, val = line.split(/:\s?/)
        request[normalize_key(key)] = val.chomp
      end
    end

    def post_data?
      @http_method == 'POST' && @request.has_content?
    end

    def parse_post_data
      @raw_request.read @request.content_length
    end

    def normalize_key(key)
      key.upcase.gsub '-', '_'
    end
  end
end