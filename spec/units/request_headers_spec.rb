require "spec_helper"

describe Kwipper::RequestHeaders do
  subject do
    described_class.new.tap { |r| r[:test] = true }
  end

  context "#[]" do
    it "returns the header value for the key" do
      expect(subject["TEST"]).to eq "true"
    end

    it "returns nil if no key exists in the headers" do
      expect(subject[:nope]).to be nil
    end
  end

  context "#[]=" do
    it "assigns a value to the headers for the key" do
      subject[:test2] = 42
      expect(subject["TEST2"]).to eq "42"
    end

    it "capitalizes and underscores keys" do
      subject['content-length'] = "1"
      expect(subject["CONTENT_LENGTH"]).to eq "1"
    end

    it "removes trailing whitespace from the values" do
      subject['content-type'] = "text/html\r\n"
      expect(subject["CONTENT_TYPE"]).to eq "text/html"
    end
  end

  context "#cookies" do
    it "parses and memoizes the cookie header and returns a hash" do
      subject['cookie'] = "a=1; b=2\r\n"

      expect(subject.cookies).to eq "a" => "1", "b" => "2"
      expect(subject.cookies.object_id).to be subject.cookies.object_id
    end
  end

  context "#content_length" do
    it "converts the content length header value to an integer" do
      subject['content-length'] = "1\r\n"
      expect(subject.content_length).to be 1
    end
  end
end
