require "spec_helper"

describe Kwipper::HttpParser do
  subject { described_class.new }

  context '#parse' do
    it "raises empty request error when request is nil" do
      r = double 'raw_request', gets: nil

      expect { subject.parse r }.to raise_error Kwipper::EmptyRequestError
    end

    it "builds and returns a request object" do
      r = StringIO.new "GET / HTTP 1.1\r\n\r\n"
      request = subject.parse r

      expect(request).to be_a Kwipper::Request
    end

    it "gets the first line of the request" do
      r = StringIO.new "GET / HTTP 1.1\r\n\r\n"
      subject.parse r

      expect(subject.first_line).to eq "GET / HTTP 1.1\r\n"
    end
  end

  context "got first line" do
    subject { described_class.new.tap { |p| p.parse raw_request } }
    let :raw_request do
      StringIO.new "PUT /post?q=1 HTTP 1.1\r\nContent-length: 4\r\n\r\nBody\r\n"
    end

    context "#parse_path" do
      it "returns the path of the request" do
        expect(subject.send :parse_path).to eq "/post"
      end
    end

    context "#parse_query" do
      it "converts the query string into a hash and returns it" do
        expect(subject.send :parse_query).to eq "q" => "1"
      end

      it "returns an empty hash if there was no query string" do
        p = described_class.new
        p.parse StringIO.new("GET /home HTTP 1.1\r\n\r\n")
        
        expect(p.send :parse_query).to eq({})
      end
    end

    context "#parse_headers" do
      it "converts the headers of the request into a hash and returns it" do
        p = described_class.new
        raw_request.gets # simulate the getting the first line first

        expect(p.send :parse_headers, raw_request).to eq "CONTENT_LENGTH" => "4"
      end

      it "returns an empty hash when there were no headers" do
        p = described_class.new
        r = StringIO.new "PUT /post?q=1 HTTP 1.1\r\n\r\n"
        r.gets

        expect(p.send :parse_headers, r).to eq({})
      end
    end

    context "#read_body" do
      it "reads the request body and parses it into a hash" do
        p = described_class.new
        r = StringIO.new "PUT / HTTP 1.1\r\nContent-length: 4\r\n\r\nq=1\r\n"
        r.gets
        p.send :parse_headers, r # have to read headers before the body

        expect(subject.send :read_body, r, 3).to eq "q" => "1"
      end
    end
  end
end