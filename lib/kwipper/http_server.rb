module Kwipper
  class HttpServer < TCPServer
    DEFAULT_PORT = 80
    attr_reader :host

    def self.start(host, port)
      HttpServer.new(host, port).serve
    end

    def initialize(host, port)
      @host, @port = host, port
      @host = "#@host#{":#@port" unless port.to_i == DEFAULT_PORT}"
      log.info "Starting server on #@host"
      @http_parser = HttpParser.new
      @worker = Worker.new CONCURRENCY
      Kwipper.load_app
      super
    end

    def serve
      Kwipper.log_startup_time

      loop do
        @worker.will accept do |socket|
          begin
            request = @http_parser.parse socket

            log.info "#{request.info} #{request.params.inspect unless request.params.empty?}".strip.green

            response = Application.new.respond_to request
            socket.write response.to_http_response
            socket.flush

          rescue Errno::ECONNRESET, Errno::EPIPE => e
            log.info "#{e.class} #{e.message}".yellow
          rescue Kwipper::EmptyRequestError => e
            log.warn "#{e.class} #{e.message}".yellow
          ensure
            socket.close unless socket.closed?
          end
        end
      end

    rescue Interrupt
      Model.db.close
      log.debug "Ok bye."
    end
  end
end