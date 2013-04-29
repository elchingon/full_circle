require "spec_helper"

describe FullCircle::Connection do

  subject {FullCircle::Connection.new "360durango.com"}

  its(:domain) {should == "360durango.com"}
  its(:base_uri) {should == "http://api.360durango.com/1.0/"}

  describe ".call_api_method" do

    it "should request the correct uri" do
      req_stub = stub_http_request(:get, "api.360durango.com/1.0/ad.getCoupons").with(query: {adId: "81304"})

      subject.call_api_method "ad.getCoupons", adId: "81304"

      req_stub.should have_been_requested

    end


  end


end
