module Kwipper
  class RequestHeaders
    def initialize
      @headers = {}
    end

    def [](key)
      @headers[key]
    end

    def []=(key, val)
      @headers[normalize_key(key)] = val.to_s.chomp
    end

    def cookies
      @cookies ||= begin
        c = @headers['COOKIE'].to_s.split(/;\s?/)
        c = c.map { |c| c.split '=' }
        c.size.even? ? Hash[c] : {}
      end
    end

    def content_length
      @headers['CONTENT_LENGTH'].to_i
    end

    private

    def normalize_key(key)
      key.to_s.upcase.gsub '-', '_'
    end
  end
end