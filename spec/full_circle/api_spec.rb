require 'spec_helper'
require 'vcr'

describe FullCircle::API do

  describe "#fetch_events_for_ad" do

    it "should an array of events" do
      api = FullCircle::API.new(FullCircle::Connection.new("360durango.com"))

      VCR.use_cassette "single_get_events_response" do
        results = api.fetch_events_for_ad "81213"
        results.should be_a Array
        results.first.should be_a FullCircle::Event
      end

    end

  end

end
