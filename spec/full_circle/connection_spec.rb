require "spec_helper"

describe FullCircle::Connection do

  subject {FullCircle::Connection.new "360durango.com"}

  its(:domain) {should == "360durango.com"}
  its(:base_uri) {should == "http://api.360durango.com/1.0/"}

  let!(:req_stub) {stub_http_request(:get, "api.360durango.com/1.0/ad.getCoupons").with(query: {adId: "81304"})
    .to_return(body: "abc")
  }

  describe ".call_api_method" do

    it "should request the correct uri" do
      subject.call_api_method "ad.getCoupons", adId: "81304"

      req_stub.should have_been_requested
    end

    it "should return the correct data" do
      response = subject.call_api_method "ad.getCoupons", adId: "81304"
      response.body.should eq("abc")
    end

    context "without cache" do
      it "should make the http request each time" do
        subject.call_api_method "ad.getCoupons", adId: "81304"
        subject.call_api_method "ad.getCoupons", adId: "81304"

        req_stub.should have_been_requested.twice
      end
    end

    context "with cache" do
      subject {FullCircle::Connection.new "360durango.com", cache: {}}

      it "should make the http request each time" do
        subject.call_api_method "ad.getCoupons", adId: "81304"
        subject.call_api_method "ad.getCoupons", adId: "81304"

        req_stub.should have_been_requested.once
      end
    end

  end


end
