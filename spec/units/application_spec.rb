require "spec_helper"
require "kwipper/application"

describe Kwipper::Application do
  let(:app) { described_class.new }
  let(:request) { Fixtures.request }

  context "#respond_to" do
    it "accepts a request and returns a response" do
      response = app.respond_to request

      expect(response).to be_a Kwipper::Response
    end

    it "calls process!" do
      expect(app).to receive(:process!)
      app.respond_to request
    end

    it "handles not found errors and sets the response status to 404" do
      request.path = 'nope'
      response = app.respond_to request

      expect(response.info).to eq "404 Not Found: GET nope"
    end

    it "handles authentication errors and sets the response status to 401" do
      request.path = '/users/new'
      response = app.respond_to request

      expect(response.info).to eq "401 Unauthorized"
    end

    it "handles Exception and sets response status to 500" do
      request.path = '/test/raise_error'
      response = app.respond_to request

      expect(response.info).to eq "500 Server Error"
    end

    it "sets the view and the response body" do
      request.path = '/test/response_body'
      response = app.respond_to request    

      expect(response.body).to match "Success!" # the body is HTML
    end
  end
end