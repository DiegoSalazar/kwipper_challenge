require "spec_helper"

describe Kwipper::HttpServer do
  let :http_server do
    server = described_class.new 'localhost', 9000
    req = double "request", gets: Kwipper::HttpParser::HEADER_DELIMITER, 
                            closed?: true,
                            send: nil,
                            flush: nil
    expect(server).to receive(:accept).and_return req
    server
  end

  context '#serve' do
    it "loads the app code" do
      expect(Kwipper).to receive(:load_app)

      http_server.serve
    end

    it "accepts connections" do
      http_server.serve
      # the expectation is in the let declaration
    end

    it "writes an HTTP response to the socket" do
      server, socket = open_server
      expect(socket).to receive(:write).with /HTTP\/1.1/

      switch_off_socket server
      server.serve
    end

    it "closes the socket after an accept" do
      server, socket = open_server false
      expect(socket).to receive :write
      expect(socket).to receive :close

      switch_off_socket server
      server.serve
    end
  end

  def open_server(socket_closed = true)
    @open_server ||= begin
      server = Kwipper::HttpServer.new 'localhost', 9001
      socket = double 'socket', gets: "\r\n", closed?: socket_closed
      
      expect(server).to receive(:accept).and_return socket

      [server, socket]
    end
  end

  # This will make the accept method return nil the 2nd time 
  # it's called thereby exiting the server's while loop
  def switch_off_socket(server)
    Thread.new { sleep 0; expect(server).to receive(:accept).and_return nil }
  end
end