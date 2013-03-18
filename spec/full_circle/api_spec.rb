require 'spec_helper'
require 'vcr'

describe FullCircle::API do

  let!(:api){FullCircle::API.new(FullCircle::Connection.new("360durango.com"))}

  describe "#fetch_events_for_ad" do

    context "with one event" do
      it "returns an array of one event" do
        VCR.use_cassette "single_get_events_response" do
          results = api.fetch_events_for_ad "81213"
          results.should be_a Array
          results.first.should be_a FullCircle::Event
        end
      end

    end
    
    context "with multiple events" do
      it "returns an array of multiple events" do
        VCR.use_cassette "multple_get_events_response" do
          results = api.fetch_events_for_ad "89690"
          results.should be_a Array
          (results.length > 1).should be_true
          results.first.should be_a FullCircle::Event
        end
      end
    end

    context "with no events" do
      it "returns an empty array" do
        VCR.use_cassette "empty_get_events_response" do
          results = api.fetch_events_for_ad "1"
          results.should eq []
        end
      end
    end

  end


  describe "#fetch_coupons_for_ad" do
    
    context "with one coupon" do
      it "returns an array of one coupon" do
        VCR.use_cassette "single_get_coupons_response" do
          results = api.fetch_coupons_for_ad "123094"
          results.should be_a Array
          results.length.should eq 1
          results.first.should be_a FullCircle::Coupon
        end
      end
    end

    context "with multiple coupons" do
      it "returns an array of multiple coupons" do
        VCR.use_cassette "multiple_get_coupons_response" do
          results = api.fetch_coupons_for_ad "82196"
          results.should be_a Array
          results.length.should eq 3
          results.first.should be_a FullCircle::Coupon
        end
      end
    end

    context "with no coupons" do
      it "returns an empty array" do
        VCR.use_cassette "empty_get_coupons_response" do
          results = api.fetch_coupons_for_ad "1"
          results.should eq []
        end
      end
    end
  end

end
