require 'spec_helper'

describe FullCircle::Ad do
  describe "#events" do
    it "should return an array of events" do
      ad = FullCircle::Ad.new "81303"
      ad.events.should be_an Array
    end
  end
end
