require "spec_helper"

describe Kwipper::Controller do
  let(:controller) do
    request = Fixtures.request
    described_class.new request, Kwipper::Response.new(request)
  end

  context ".add_routes" do
    it "merges the hash argument with the ROUTES constant hash" do
      described_class.add_routes [:GET, "/test"] => :test

      expect(described_class::ROUTES.keys.last).to eq [:GET, "/test"]
    end

    it "sets the values of the ROUTES hash to an array of the controller class and action name" do
      described_class.add_routes [:GET, "/test"] => :test

      expect(described_class::ROUTES.values.last).to eq [Kwipper::Controller, :test]
    end
  end

  context "process" do
    it "sets the action" do
      controller.process :home

      expect(controller.action).to eq :home
    end

    it "calls a method of the same name as the action on itself" do
      expect(controller).to receive(:home)

      controller.process :home      
    end
  end

  context "home" do
    it "renders the home view" do
      view = controller.home

      expect(view).to match '<h1>Kwipper</h1>'
    end
  end

  context "require_login!" do
    it "raises an authentication required error if there is no current session" do
      expect(controller.response).to receive(:has_session?).and_return false

      expect { controller.send :require_login! }.to raise_error Kwipper::AuthenticationRequired
    end

    it "does nothing if there's a current session" do
      expect(controller.response).to receive(:has_session?).and_return true
      expect(Kwipper::Session).to receive(:find).and_return true

      expect { controller.send :require_login! }.to_not raise_error
    end
  end
end