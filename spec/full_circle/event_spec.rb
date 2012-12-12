require "spec_helper"

describe FullCircle::Event do

  describe "#initialize" do
    it "should set instance variables based on the array that was passed in" do
      event = described_class.new({"id" => "156", "title" => "Hello World"})
      event.id.should eq "156"
      event.title.should eq "Hello World"

    end

  end

end
