$START_TIME = Time.now.to_f
$LOAD_PATH.unshift("./lib") unless $LOAD_PATH.include?("./lib")

require "socket"
require "securerandom"
require "pg"
require "erb"
require "uri"
require "logger"
require "mime-types"
require "rack/utils"
require "colorize"
require "redcarpet"
require "pygments"
require "kwipper/util"

begin
  require "pry"
rescue => e
  puts e.message
  puts "pry not installed"
end

module Kwipper
  extend Util

  ROOT = Dir.pwd
  APP_TITLE = ENV.fetch "APP_TITLE", "Kwipper"
  HOST = ENV.fetch "HOST", "localhost"
  PORT = ENV.fetch "PORT", "7335"
  CONCURRENCY = ENV.fetch "CONCURRENCY", 4

  def self.run
    HttpServer.start HOST, PORT
  end

  def self.load_app
    %w(app/models/**/*.rb
       app/controllers/**/*.rb
       app/decorators/**/*.rb
       app/services/**/*.rb).each { |path| load_files_at path }
  end

  def self.load_files_at(glob)
    Dir[File.join ROOT, glob].each { |file| require file }
  end
end

# Constants
require "kwipper/version"
require "kwipper/errors"
# Server
require "kwipper/http_server"
require "kwipper/http_parser"
require "kwipper/request"
require "kwipper/response"
# Helpers
require "kwipper/controller_helpers"
require "kwipper/renders_views"
require "kwipper/inflect"
# Framework
require "kwipper/application"
require "kwipper/controller"
require "kwipper/decorator"
require "kwipper/router"
require "kwipper/model"

Kwipper.run if __FILE__ == $0
