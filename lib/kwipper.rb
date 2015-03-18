$START_TIME = Time.now.to_f
require "socket"
require "uri"
require "securerandom"
require "sqlite3"
require "erb"
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
  @logger ||= Logger.new STDOUT
end

require "kwipper/version"
require "kwipper/errors"
require "kwipper/http_parser"
require "kwipper/http_server"
require "kwipper/request"
require "kwipper/request_headers"
require "kwipper/response"
require "kwipper/view_renderer"
require "kwipper/view_helpers"
require "kwipper/session_helpers"
require "kwipper/model"
require "kwipper/controllers"
require "kwipper/application"

Kwipper::HttpServer.run if __FILE__ == $0