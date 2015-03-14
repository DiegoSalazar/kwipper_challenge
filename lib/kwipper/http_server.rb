module Kwipper
  class HttpServer < TCPServer
    DEFAULT_PORT = 80
    attr_reader :host

    def initialize(bind = '127.0.0.1', port = 7335)
      @bind, @port = bind, port
      @host = "#@bind#{":#@port" unless port.to_i == DEFAULT_PORT}"
      log.debug "Starting server on #@host"
      super
    end

    def serve(application)
      parser = HttpParser.new self

      while socket = accept
        begin
          request = parser.parse socket
          log.info request.info

          response = Response.new request, application
          socket.write response.to_http_response

        rescue Errno::ECONNRESET, Errno::EPIPE => e
          log.info e.message
        ensure
          socket.close
        end
      end

    rescue Interrupt
      socket.close if socket && !socket.closed?
      log.debug "Ok bye."
    end
  end
end