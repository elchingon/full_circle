require "spec_helper"

describe FullCircle::Connection do

  subject {FullCircle::Connection.new "360durango.com"}

  its(:domain) {should == "360durango.com"}
  its(:base_uri) {should == "http://api.360durango.com/1.0/"}

  describe ".call_api_method" do
    it "should call HTTParty.get with the correct arguments" do
      HTTParty.should_receive(:get).with("ad.getCoupons",base_uri: subject.base_uri, query: {adId: "81304"})

      subject.call_api_method "ad.getCoupons", adId: "81304"
    end


  end


end
