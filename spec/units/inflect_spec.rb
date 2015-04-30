require "spec_helper"

describe Kwipper::Inflect do
  subject { "Kwipper::UserStuff" }
  let(:inflected) { described_class.new subject }

  it "always returns an Inflect string so that inflections can be chained" do
    expect(described_class.plural(2, subject).demodulize.underscore).to eq "user_stuffs"
  end

  context ".plural" do
    it "returns a string pluralized when the count is greater than 1" do
      expect(described_class.plural(2, subject)).to eq "2 Kwipper::UserStuffs"
    end

    it "does not pluralize when the count is 1 or less" do
      expect(described_class.plural(1, subject)).to eq "1 Kwipper::UserStuff"
    end
  end

  context "#demodulize" do
    it "returns the last segment of a Ruby model name" do
      expect(inflected.demodulize).to eq "UserStuff"
    end
  end

  context "#pluralize" do
    it "returns a pluralized string" do
      expect(inflected.pluralize).to eq "Kwipper::UserStuffs"
    end
  end

  context "#underscore" do
    it "converts a camel cased string to snake case" do
      expect(inflected.underscore).to eq "kwipper::user_stuff"
    end
  end
end
