require "spec_helper"
require "kwipper/http_parser"

describe Kwipper::HttpParser do
  let(:http_parser) { described_class.new }

  context '#parse' do
    it "raises empty request error when request is nil" do
      r = double 'raw_request', gets: nil

      expect { http_parser.parse r }.to raise_error Kwipper::EmptyRequestError
    end

    it "builds and returns a request object" do
      r = StringIO.new "GET / HTTP 1.1\r\n\r\n\r\n"
      request = http_parser.parse r

      expect(request).to be_a Kwipper::Request
    end
  end
end