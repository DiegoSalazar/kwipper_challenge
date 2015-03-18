module Kwipper
  class RequestHeaders
    def initialize
      @headers = {}
    end

    def []=(key, val)
      @headers[normalize_key(key)] = val.chomp
    end

    def [](key)
      @headers[key]
    end

    def content_length
      @headers['CONTENT_LENGTH'].to_i
    end

    def has_content?
      content_length > 0
    end

    def cookies
      @cookies ||= begin
        c = @headers['COOKIE'].to_s.split(/;\s?/).map { |c| c.split '=' }
        c.size.even? ? Hash[c] : {}
      end
    end

    private

    def normalize_key(key)
      key.upcase.gsub '-', '_'
    end
  end
end