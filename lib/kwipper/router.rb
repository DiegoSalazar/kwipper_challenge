module Kwipper
  class Router
    # matches words with dashes in it prefixed by a colon:
    # e.g. "/hey/:page/yo" matches ":page"
    SEGMENT_KEY_REGEX = /(:[a-z\-?]+)/
    
    # matches lowercased words with dashes and digits in it between slashes:
    # e.g. "/hey/there/yo" matches "hey", "there", "yo"
    SEGMENT_VALUE_REGEX = /([a-z0-9\-?]+)/
    
    # match a forward slash not preceded by a space
    # e.g. "GET /tutorials/the-page" matches the "/" before "the-page"
    INNER_SLASH_REGEX = /(?<!\s)\//

    attr_reader :segments

    def initialize(routes)
      @routes = routes
      @segments = {}
    end

    def route?(request_info)
      @request_info = request_info
      
      if @routes.key? request_info # plain route
        true
      elsif (route = find_match request_info)
        # overwrite the segments hash for every request
        @segments = extract_segments request_info, route.first.to_s.dup
        true
      else
        false
      end
    end

    # returns the controller_class and action name
    def dispatch(request_info = @request_info)
      find_match(request_info).last 2
    end

    private

    def find_match(request_info)
      match = @routes.select do |info, _|
        route_root(info) == route_root(request_info) &&
          info.scan("/").size == request_info.scan("/").size
      end

      (m = match.to_a.flatten).empty? ? nil : m
    end

    def extract_segments(request_info, route_info)
      segment_keys = route_info.scan(SEGMENT_KEY_REGEX).flatten
      
      segment_keys.each do |key|
        route_info.gsub! key, SEGMENT_VALUE_REGEX.to_s
      end

      segment_keys.map! { |k| k.sub ":", "" }

      matched_segments = request_info.match(Regexp.new(route_info)).to_a
      matched_segments.shift # Get rid of first match, only need the group matches

      Hash[segment_keys.zip(matched_segments)]
    end

    def route_root(request_info)
      request_info.split(INNER_SLASH_REGEX).first
    end
  end
end