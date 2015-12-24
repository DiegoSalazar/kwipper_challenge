require "spec_helper"

describe Kwipper::PageNavigator do
  let :pages do
    (0..9).map { |i| Kwipper::Page.new.tap { |p| p.id = i }}
  end

  context "#prev" do
    it "returns the page before the current page" do
      navigator = described_class.new pages[4], pages

      expect(navigator.prev).to be pages[3]
    end

    it "returns nil if on the first page" do
      navigator = described_class.new pages[0], pages

      expect(navigator.prev).to be nil
    end
  end

  context "#next" do
    it "returns the page after the current page" do
      navigator = described_class.new pages[4], pages

      expect(navigator.next).to be pages[5]
    end

    it "returns nil if on the last page" do
      navigator = described_class.new pages[9], pages

      expect(navigator.next).to be nil
    end
  end
end
