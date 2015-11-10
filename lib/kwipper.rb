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
require "redcarpet"
require "pygments"
require "kwipper/util"

begin
  require "pry"
rescue
  puts "pry not installed"
end

module Kwipper
  ROOT = Dir.pwd
  APP_TITLE = ENV.fetch "APP_TITLE", "Kwipper"
  extend Util

  def self.run
    HttpServer.run
  end

  def self.load_app
    load_files "app/models/**/*.rb"
    load_files "app/controllers/**/*.rb"
    load_files "app/decorators/**/*.rb"
    load_files "app/services/**/*.rb"
  end

  def self.load_files(glob)
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
