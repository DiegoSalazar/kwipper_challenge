require "spec_helper"

class MockApp
  include Kwipper::RendersViews
end

describe Kwipper::RendersViews do
  subject { MockApp.new }
  before :each do
    view_path = Kwipper.file "spec/fixtures/test.erb"
    expect(subject).to receive(:file_path_of_view).with(:test).and_return view_path
  end

  context "#render" do
    it "renders an ERB template given a view file name" do
      expect(subject.render(:test)).to eq "Hello "
    end

    it "takes a hash of vars and sets them as instance variables" do
      greet = `id -F`.chomp
      rendered = subject.render :test, greet: greet

      expect(rendered).to eq "Hello #{greet}"
    end
  end
end
