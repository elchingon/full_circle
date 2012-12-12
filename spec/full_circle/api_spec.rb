require 'spec_helper'
require 'vcr'

describe FullCircle::API do

  describe "#fetch_events_for_ad" do

    let!(:api){FullCircle::API.new(FullCircle::Connection.new("360durango.com"))}

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

end
