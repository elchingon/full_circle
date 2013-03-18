require "spec_helper"

describe FullCircle::Coupon do

  describe "#initialize" do
    it "should set instance variables based on the hash that was passed in" do
      event = described_class.new({"id" => "156", "name" => "Hello World"})
      event.id.should eq "156"
      event.name.should eq "Hello World"

    end

  end

end
