require "spec_helper"

describe Kwipper::Router do
  subject { described_class.new Fixtures.routes_hash }

  context "#route?" do
    it "returns true for plain old routes" do
      expect(subject.route? "GET /kwips/comments/new").to be true
    end

    it "returns true for named segment routes" do
      expect(subject.route? "GET /tutorials/the-page").to be true
    end

    it "populates segments when a named route is found" do
      subject.route? "GET /tutorials/the-page"

      expect(subject.segments).to eq "page" => "the-page"
    end

    it "returns false when no route found" do
      expect(subject.route? "GET /nope").to be false
    end
  end

  context "#dispatch" do
    it "returns an array of the matching controller and action name" do
      expect(subject.dispatch "GET /tutorials/the-page").to eq [Kwipper::TutorialsController, :show]
    end
  end

  context "#find_match" do
    it "returns the matching internal route given the incoming request info" do
      found_route = subject.send :find_match, "GET /tutorials/the-page"

      expect(found_route).to eq ["GET /tutorials/:page", Kwipper::TutorialsController, :show]
    end
  end

  context "#extract_segments" do
    it "returns a hash of the route segments with the segment names as keys" do
      request_info = "GET /tutorials/the-page/new/12/edit"
      route = ["GET /tutorials/:page/new/:id/edit", Kwipper::TutorialsController, :show]

      expect(subject.send :extract_segments, request_info, route).to eq({
        "page"=> "the-page", "id" => "12"
      })
    end
  end

  context "#route_root" do
    it "returns the part of the route info before the 2nd forward slash" do
      expect(subject.send :route_root, "GET /tutorials/the-page").to eq "GET /tutorials"
    end
  end
end
