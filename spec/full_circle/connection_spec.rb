require "spec_helper"

describe FullCircle::Connection do

  subject {FullCircle::Connection.new "360durango.com"}

  describe "#domain" do
    it "returns the value set in the constructor" do
      conn = described_class.new "360durango.com"

      expect(conn.domain).to eq('360durango.com')
    end
  end

  describe "#base_uri" do
    it "returns formats the domain into the proper uri" do
      conn = described_class.new "360durango.com"

      expect(conn.base_uri).to eq('http://api.360durango.com/1.0/')
    end
  end


  let!(:req_stub) {stub_request(:get, "api.360durango.com/1.0/ad.getCoupons").with(query: {adId: "81304"})
    .to_return(body: "abc")
  }

  describe ".call_api_method" do

    it "requests the correct uri" do
      subject.call_api_method "ad.getCoupons", adId: "81304"

      expect(req_stub).to have_been_requested
    end

    it "returns the correct data" do
      response = subject.call_api_method "ad.getCoupons", adId: "81304"
      expect(response.raw_xml).to eq("abc")
    end

    context "without cache" do
      it "makes the http request each time" do
        subject.call_api_method "ad.getCoupons", adId: "81304"
        subject.call_api_method "ad.getCoupons", adId: "81304"

        expect(req_stub).to have_been_requested.twice
      end
    end

    context "with cache" do
      subject {FullCircle::Connection.new "360durango.com", cache: {}}

      it "does not make the http request each time" do
        subject.call_api_method "ad.getCoupons", adId: "81304"
        subject.call_api_method "ad.getCoupons", adId: "81304"

        expect(req_stub).to have_been_requested.once
      end
    end

  end

  describe FullCircle::Connection::NullCache do
    subject {FullCircle::Connection::NullCache.new}
    it_behaves_like "a cacher"
  end


end
