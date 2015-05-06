require "spec_helper"

describe Kwipper::Application do
  subject { described_class.new }
  let(:request) { Fixtures.request }

  context "#respond_to" do
    it "accepts a request and returns a response" do
      response = subject.respond_to request

      expect(response).to be_a Kwipper::Response
    end

    it "calls process!" do
      expect(subject).to receive(:process!)
      subject.respond_to request
    end

    it "handles not found errors and sets the response status to 404" do
      request.path = "nope"
      response = subject.respond_to request

      expect(response.info).to eq "404 Not Found: GET nope"
    end

    it "handles authentication errors and sets the response status to 401" do
      request.path = "/users/new"
      response = subject.respond_to request

      expect(response.info).to eq "401 Unauthorized"
    end

    it "handles Exception and sets response status to 500" do
      request.path = "/test/raise_error"
      response = subject.respond_to request

      expect(response.info).to eq "500 Server Error"
    end

    it "sets the view and the response body" do
      request.path = "/test/response_body"
      response = subject.respond_to request    

      expect(response.body).to match "Success!" # the body is HTML
    end

    it "handles static file requests" do
      request.path ="/test.erb"
      file_path = Kwipper.file 'spec/fixtures', request.path

      expect(subject).to receive(:get_file_name).and_return file_path
      response = subject.respond_to request

      expect(response.body).to eq File.read file_path
    end

    it "sets the correct mime type for static file requests" do
      request.path ="/test.html"
      file_path = Kwipper.file 'spec/fixtures', request.path

      expect(subject).to receive(:get_file_name).and_return file_path
      response = subject.respond_to request

      expect(response.body).to eq File.read file_path
    end
  end
end