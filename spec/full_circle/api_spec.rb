require 'spec_helper'
require 'vcr'

describe FullCircle::API do

  let!(:api){FullCircle::API.new(FullCircle::Connection.new("360durango.com"))}

  describe "#fetch_events_for_ad" do
    skip "calls the appropriate method on call_api_method" do
      mock_connection = double()
      expect(mock_connection).to receive(:call_api_method).with("ad.getEvents",{adId: "1"}) do
        class ResponseDouble
          def body
          end
        end
        ResponseDouble.new
      end

      described_class.new(mock_connection).fetch_events_for_ad("1")
    end

    describe "event object", :vcr => {cassette_name: "single_get_events_response"} do
      subject {api.fetch_events_for_ad("81213").first}
      it_behaves_like "an event"
    end

    context "with one event" do
      it "returns an array of one event" do
        VCR.use_cassette "single_get_events_response" do
          results = api.fetch_events_for_ad "81213"
          expect(results).to be_a Array
          results
        end
      end

    end

    context "with multiple events" do
      it "returns an array of multiple events" do
        VCR.use_cassette "multple_get_events_response" do
          results = api.fetch_events_for_ad "89690"
          expect(results).to be_a Array
          expect(results.length > 1).to eq(true)
        end
      end
    end

    context "with no events" do
      it "returns an empty array" do
        VCR.use_cassette "empty_get_events_response" do
          results = api.fetch_events_for_ad "1"
          expect(results).to eq([])
        end
      end
    end

  end


  describe "#fetch_coupons_for_ad" do

    skip "calls the appropriate method on call_api_method" do
      mock_connection = double()
      expect(mock_connection).to receive(:call_api_method).with("ad.getCoupons",{adId: "1"})

      described_class.new(mock_connection).fetch_coupons_for_ad("1")
    end

    context "with one coupon" do
      it "returns an array of one coupon" do
        VCR.use_cassette "single_get_coupons_response" do
          results = api.fetch_coupons_for_ad "123094"
          expect(results).to be_an(Array)
          expect(results.length).to eq(1)
        end
      end
    end

    context "with multiple coupons" do
      it "returns an array of multiple coupons" do
        VCR.use_cassette "multiple_get_coupons_response" do
          results = api.fetch_coupons_for_ad "82196"
          expect(results).to be_a(Array)
          expect(results.length).to eq(3)
        end
      end
    end

    context "with no coupons" do
      it "returns an empty array" do
        VCR.use_cassette "empty_get_coupons_response" do
          results = api.fetch_coupons_for_ad "1"
          expect(results).to eq([])
        end
      end
    end
  end

  describe "#fetch_event_areas" do
    skip "calls the appropriate method on call_api_method" do
      mock_connection = double()
      expect(mock_connection).to receive(:call_api_method).with("city.getEventAreas")

      described_class.new(mock_connection).fetch_event_areas
    end

    context "with one event area" do
      it "returns an array of one event area" do
        VCR.use_cassette "single_event_areas_response" do
          results = api.fetch_event_areas
          expect(results.length).to eq(1)
        end
      end
    end

    context "with multiple event areas" do
      it "returns an array of multiple event areas" do
        VCR.use_cassette "multiple_event_areas_response" do
          results = api.fetch_event_areas
          expect(results.length).to eq(7)
        end
      end
    end

    context "with no event areas" do
      let!(:api){FullCircle::API.new(FullCircle::Connection.new("1019thewave.com"))}
      it "returns an empty array" do
        VCR.use_cassette "empty_event_area_response" do
          results = api.fetch_event_areas
          expect(results).to eq([])
        end
      end
    end

  end

  describe "#fetch_upcoming_events" do

    skip "calls the appropriate method on call_api_method" do
      mock_connection = double()
      expect(mock_connection).to receive(:call_api_method).with("city.getUpcomingEvents",{})

      described_class.new(mock_connection).fetch_upcoming_events
    end

    describe "event object", vcr: {cassette_name: "single_get_upcoming_events_response"} do

      subject {api.fetch_upcoming_events(areaId:"592").first}
      it_behaves_like "an event"
    end

    context "with one event" do
      it "returns an array of one event" do
        VCR.use_cassette "single_get_upcoming_events_response" do
          results = api.fetch_upcoming_events areaId: "592"
          expect(results.length).to eq(1)
        end
      end

    end

    context "with multiple events" do
      it "returns an array of multiple events" do
        VCR.use_cassette "multiple_get_upcoming_events_response" do
          results = api.fetch_upcoming_events
          expect(results.length > 1).to eq(true)
        end
      end
    end

    context "with no events" do
      let!(:api){FullCircle::API.new(FullCircle::Connection.new("boatersbluepages.com"))}
      it "returns an empty array" do
        VCR.use_cassette "empty_get_upcoming_events_response" do
          results = api.fetch_upcoming_events
          expect(results).to eq([])
        end
      end
    end

  end

end
