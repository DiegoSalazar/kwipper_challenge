require "spec_helper"

describe Kwipper::Request do
  subject { Fixtures.request }

  context "#initialize" do
    it "defaults post_data to an empty hash" do
      expect(described_class.new.post_data).to eq({})
    end

    it "accepts a block yielding itself" do
      described_class.new { |r| expect(r).to be_a described_class }
    end
  end

  context "#headers" do # see request_headers_spec for more info
    it "is a Hash" do
      expect(subject.headers).to be_a Hash
    end
  end

  context "#info" do
    it "returns a string of the HTTP method and path" do
      expect(subject.info).to eq "GET /test"
    end
  end

  context "#params" do
    it "merges the query hash and post_data hash and memoizes it" do
      subject.post_data = { post_data: :hash }

      expect(subject.params).to eq query: :hash, post_data: :hash
    end
  end

  context "#cookies" do
    it "returns a hash" do
      expect(subject.cookies).to eq({})
    end
  end

  context "#content_length" do
    it "returns an integer" do
      expect(subject.content_length).to be 0
    end
  end
end
