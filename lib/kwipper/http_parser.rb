module Kwipper
  class HttpParser
    HEADER_DELIMITER = "\r\n"
    
    attr_reader :http_method, :path, :query, :headers, :post_data

    def initialize(server)
      @server = server
    end

    def parse(raw_request)
      @raw_request = raw_request
      @first_line  = @raw_request.gets
      @http_method = parse_method
      @path        = parse_path
      @query       = parse_query
      @request     = parse_request
      @post_data   = parse_post_data if post_data?
      self
    end

    def info
      "#{http_method} #{@full_path}"
    end

    def host
      @server.host
    end

    def route_key
      [http_method.to_sym, path]
    end

    private

    def parse_method
      @first_line.split(' ').first
    end

    def parse_path
      get_path.split('?').first
    end

    def parse_query
      get_path.split('?').last.chomp
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
      @http_method == 'POST' && @request['CONTENT_LENGTH'].present?
    end

    def parse_post_data
      @raw_request.read @request['CONTENT_LENGTH'].to_i
    end

    def get_path
      @full_path ||= @first_line.split(' ')[1].to_s
    end

    def normalize_key(key)
      key.upcase.gsub '-', '_'
    end
  end
end