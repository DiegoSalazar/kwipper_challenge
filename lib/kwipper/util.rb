module Kwipper
  module Util
    def log_startup_time
      log.info "Started in #{sprintf "%.2f", Time.now.to_f - $START_TIME}s"
    end

    def file(*args)
      File.join Kwipper::ROOT, *args
    end

    def benchmark(text)
      s = Time.now.to_f
      yield.tap { log.info text % "#{sprintf("%.8f", Time.now.to_f - s)}s" }
    end

    def html_escape(string)
      CGI.escapeHTML string
    end

    def html_unescape(string)
      CGI.unescapeHTML string
    end
  end
end

# Global
def log
  @logger ||= Logger.new(STDOUT).tap do |logger|
    logger.datetime_format = "%Y-%m-%d %H:%M:%S "
    logger.level = ENV.fetch("LOG_LEVEL", Logger::DEBUG).to_i
  end
end