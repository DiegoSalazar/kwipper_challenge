module Kwipper
  class HttpParser
    HEADER_DELIMITER = "\r\n"
    attr_reader :request_method, :path, :query, :headers, :post_data

    def self.parse(request)
      new(request).parse
    end

    def initialize(raw_request)
      @raw_request = raw_request
    end

    def parse
      @first_line     = @raw_request.gets
      @request_method = parse_method
      @path           = parse_path
      @query          = parse_query
      @headers        = parse_headers
      @post_data      = parse_post_data if accept_post_data?
      self
    end

    def info
      "#{request_method} #{@full_path}"
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

    def parse_headers
      lines = []

      while (line = @raw_request.gets) != HEADER_DELIMITER
        lines << line.chomp
      end

      lines.each_with_object({}) do |line, headers|
        key, val = line.split(/:\s?/)
        headers.merge! normalize_key(key) => val.chomp
      end
    end

    def accept_post_data?
      @request_method == 'POST' && @headers.key?('CONTENT_LENGTH')
    end

    def parse_post_data
      @raw_request.read @headers['CONTENT_LENGTH'].to_i
    end

    def get_path
      @full_path ||= @first_line.split(' ')[1].to_s
    end

    def normalize_key(key)
      key.upcase.gsub '-', '_'
    end
  end
end