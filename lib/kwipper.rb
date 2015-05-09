$START_TIME = Time.now.to_f
require "socket"
require "securerandom"
require "pg"
require "erb"
require "uri"
require "logger"
require "mime-types"
require "rack/utils"
require "colorize"
require "pry"

module Kwipper
  ROOT = Dir.pwd
  module_function

  def run
    HttpServer.run
  end

  def load_models
    Dir[File.join(ROOT, 'app/models/**/*.rb')].each do |model|
      require model
    end
  end

  def load_controllers
    Dir[File.join(ROOT, 'app/controllers/**/*.rb')].each do |controller|
      require controller
    end
  end

  def log_startup_time
    log.info "Started in #{sprintf '%.2f', Time.now.to_f - $START_TIME}s"
  end

  def file(*args)
    File.join Kwipper::ROOT, *args
  end
end

def log
  @logger ||= Logger.new(STDOUT).tap do |logger|
    logger.datetime_format = '%Y-%m-%d %H:%M:%S '
    logger.level = ENV.fetch('LOG_LEVEL', Logger::DEBUG).to_i
  end
end

# Constants
require "kwipper/version"
require "kwipper/errors"
# Server
require "kwipper/http_parser"
require "kwipper/http_server"
require "kwipper/request"
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

Kwipper.run if __FILE__ == $0
