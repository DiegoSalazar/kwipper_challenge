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
require "kwipper/util"

module Kwipper
  ROOT = Dir.pwd
  extend Util

  module_function

  def run
    HttpServer.run
  end

  def load_app
    load_controllers
    load_decorators
    load_models
  end

  def load_models
    Dir[File.join(ROOT, "app/models/**/*.rb")].each do |model|
      require model
    end
  end

  def load_controllers
    Dir[File.join(ROOT, "app/controllers/**/*.rb")].each do |controller|
      require controller
    end
  end

  def load_decorators
    Dir[File.join(ROOT, "app/decorators/**/*.rb")].each do |decorator|
      require decorator
    end
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
require "kwipper/decorator"
# Framework
require "kwipper/application"
require "kwipper/controller"
require "kwipper/router"
require "kwipper/model"
# Extensions
require "kwipper/paginator"

Kwipper.run if __FILE__ == $0
