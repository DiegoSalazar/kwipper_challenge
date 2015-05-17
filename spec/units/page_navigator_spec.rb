require "spec_helper"

describe Kwipper::PageNavigator do
  context "#prev" do
    it "returns the page before the current page" do
      navigator = described_class.new 4, (0..9).to_a

      expect(navigator.prev).to be 3
    end

    it "returns nil if on the first page" do
      navigator = described_class.new 0, (0..9).to_a

      expect(navigator.prev).to be nil
    end
  end

  context "#next" do
    it "returns the page after the current page" do
      navigator = described_class.new 4, (0..9).to_a

      expect(navigator.next).to be 5
    end

    it "returns nil if on the last page" do
      navigator = described_class.new 9, (0..9).to_a

      expect(navigator.next).to be nil
    end
  end
end
