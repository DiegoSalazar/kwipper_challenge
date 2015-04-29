module Kwipper
  class HttpServer < TCPServer
    DEFAULT_PORT = 80
    attr_reader :host

    def self.run(bind = '127.0.0.1', port = 7335)
      HttpServer.new(bind, port).serve
    end

    def initialize(bind, port)
      @bind, @port = bind, port
      @host = "#@bind#{":#@port" unless port.to_i == DEFAULT_PORT}"
      log.debug "Starting server on #@host"
      super
    end

    def serve
      Kwipper.load_models
      Kwipper.load_controllers
      parser = HttpParser.new
      Kwipper.log_startup_time

      while socket = accept
        begin
          request = parser.parse socket

          log.info "#{request.info} #{request.params.inspect unless request.params.empty?}".strip.green

          response = Application.new.respond_to request
          socket.write response.to_http_response

        rescue Errno::ECONNRESET, Errno::EPIPE => e
          log.info "#{e.class} #{e.message}".yellow
        rescue Kwipper::EmptyRequestError => e
          log.warn "#{e.class} #{e.message}".yellow
        ensure
          socket.close unless socket.closed?
        end
      end

    rescue Interrupt
      socket.close if socket && !socket.closed?
      Model.db.close
      log.debug "Ok bye."
    end
  end
end