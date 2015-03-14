require "kwipper/version"
require "socket"
require "erb"
require "logger"
require "kwipper/http_parser"
require "kwipper/http_server"
require "kwipper/response"
require "kwipper/view_renderer"
require "kwipper/action_responders"
require "kwipper/application"

require 'pry'

def log
  @logger ||= Logger.new STDOUT
end

module Kwipper
  ROOT = Dir.pwd

  def self.run
    server = HttpServer.new
    application = Application.new
    server.serve application
  end
end

Kwipper.run
