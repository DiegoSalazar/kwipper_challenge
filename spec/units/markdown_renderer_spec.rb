require "spec_helper"

describe Kwipper::MarkdownRenderer do
  subject { described_class.new :from, :to }

  context "#process" do
    it "renders the HTML in the :from key and puts the result in the :to key" do
      attrs = { from: "# I'ma Header" }

      expect(subject.process(attrs)[:to]).to eq "<h1>I&#39;ma Header</h1>\n"
    end

    it "highlights code blocks by wrapping them in a .highlight div" do
      code_block = <<-RUBY
        ```ruby
        @stuff = :things
        ```
      RUBY
      attrs = { from: code_block }

      expect(subject.process(attrs)[:to]).to match "class=\"highlight"
    end

    it "renders custom github header links"

    it "doesn't render if :from is nil or empty" do
      expect(subject.process(from: nil)).to_not have_key :to
    end

    it "doesn't render if :from is the same as :orig_form" do
      renderer = described_class.new :from, :to, "no change"

      expect(renderer.process(from: "no change")).to_not have_key :to
    end
  end
end
