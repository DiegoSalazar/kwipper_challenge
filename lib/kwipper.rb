$START_TIME = Time.now.to_f
require "socket"
require "securerandom"
require "sqlite3"
require "erb"
require "uri"
require "logger"
require "mime-types"
require "rack/utils"
require "colorize"
require "pry"

module Kwipper
  ROOT = Dir.pwd

  def self.log_startup_time
    log.debug "Started in #{sprintf '%.2f', Time.now.to_f - $START_TIME}s"
  end
end

def log
  @logger ||= Logger.new(STDOUT).tap do |logger|
    logger.datetime_format = '%Y-%m-%d %H:%M:%S '
  end
end

require "kwipper/version"
require "kwipper/errors"
# Server
require "kwipper/http_parser"
require "kwipper/http_server"
require "kwipper/request"
require "kwipper/request_headers"
require "kwipper/response"
# Helpers
require "kwipper/inflect"
require "kwipper/renders_views"
require "kwipper/controller_helpers"
# Micro framework
require "kwipper/application"
require "kwipper/controller"
require "kwipper/model"
# Extensions
require "kwipper/paginator"

Kwipper::HttpServer.run if __FILE__ == $0
