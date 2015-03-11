require "kwipper/version"
require "socket"
require "logger"
require "kwipper/http_parser"
require "kwipper/http_server"
require "kwipper/response"
require "kwipper/application"

require 'pry'

def log
  @logger ||= Logger.new STDOUT
end

module Kwipper
  def self.run
    server = HttpServer.new
    application = Application.new
    server.serve application
  end
end

Kwipper.run
