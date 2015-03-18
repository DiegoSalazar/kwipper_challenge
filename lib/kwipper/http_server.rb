module Kwipper
  class HttpServer < TCPServer
    DEFAULT_PORT = 80
    attr_reader :host

    def self.run(bind = '127.0.0.1', port = 7335)
      HttpServer.new(bind, port).serve
    end

    def initialize(bind = '127.0.0.1', port = 7335)
      @bind, @port = bind, port
      @host = "#@bind#{":#@port" unless port.to_i == DEFAULT_PORT}"
      log.debug "Starting server on #@host"
      super
    end

    def serve
      load_models
      parser = HttpParser.new
      application = Application.new
      Kwipper.log_startup_time

      while socket = accept
        begin
          request = parser.parse socket
          log.info request.info

          response = application.respond_to request
          socket.write response.to_http_response

        rescue Errno::ECONNRESET, Errno::EPIPE => e
          log.info "#{e.class} #{e.message}"
        rescue Kwipper::EmptyRequest => e
          log.warn "#{e.class} #{e.message}"
        ensure
          socket.close
        end
      end

    rescue Interrupt
      socket.close if socket && !socket.closed?
      Model.db.close
      log.debug "Ok bye."
    end

    private

    def load_models
      Dir[File.join(Kwipper::ROOT, 'app/models/**/*.rb')].each do |model|
        require model
      end
    end
  end
end