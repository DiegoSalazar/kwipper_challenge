module Kwipper
  class HttpServer < TCPServer
    def initialize(bind = '127.0.0.1', port = 7335)
      @bind, @port = bind, port
      super @bind, @port
    end

    def serve(application)
      log.debug "Starting server on #{@bind}:#{@port}"

      while socket = accept
        begin
          request = HttpParser.parse socket
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