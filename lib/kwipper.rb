require "socket"
require "sqlite3"
require "erb"
require "logger"
require 'pry'

require "kwipper/version"
require "kwipper/http_parser"
require "kwipper/http_server"
require "kwipper/response"
require "kwipper/view_renderer"
require "kwipper/action_responders"
require "kwipper/application"
require "kwipper/model"

def log
  @logger ||= Logger.new STDOUT
end

module Kwipper
  ROOT = Dir.pwd

  Dir[File.join(ROOT, 'app/models/**/*.rb')].entries.each do |model|
    require model
  end

  def self.run
    server = HttpServer.new
    application = Application.new
    server.serve application
  end
end

Kwipper.run if __FILE__ == $0
