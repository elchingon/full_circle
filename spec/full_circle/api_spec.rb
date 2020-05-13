require 'spec_helper'
require 'vcr'

describe FullCircle::API do

  let(:connection){FullCircle::Connection.new("360durango.com")}
  let(:api){FullCircle::API.new(connection)}

  describe "#fetch_events_for_ad" do

    it "returns an array of one event" do
      VCR.use_cassette "get_events_for_ad_response" do
        results = api.fetch_events_for_ad "81299"
        expect(results.length > 0).to eq(true)
      end
    end

    context "with no events" do
      it "returns an empty array" do
        VCR.use_cassette "empty_get_events_for_ad_response" do
          results = api.fetch_events_for_ad "1"
          expect(results.length).to eq(0)
        end
      end
    end
  end


  describe "#fetch_coupons_for_ad" do

    it "calls the appropriate method on call_api_method" do
      parser = instance_double("FullCircle::Parsing::ResponseParser",
        parse: double('result', entities: []))
      mock_connection = instance_double("FullCircle::Connection")
      allow(mock_connection).to receive(:call_api_method)

      described_class.new(mock_connection, response_parser: parser).fetch_coupons_for_ad("1", page: 2)
      expect(mock_connection).to have_received(:call_api_method).with("ad.getCoupons",{adId: "1", page: 2, resultsPerPage: 20})
    end

    it "returns an array of coupons" do
      VCR.use_cassette "get_coupons_for_ad_response" do
        results = api.fetch_coupons_for_ad "89588"
        expect(results.length > 0).to eq(true)
      end
    end

    context "with no coupons" do
      it "returns an empty array" do
        VCR.use_cassette "empty_get_coupons_response" do
          results = api.fetch_coupons_for_ad "1"
          expect(results.length).to eq(0)
        end
      end
    end
  end
 
  describe "#fetch_jobs_for_ad" do

    it "calls the appropriate method on call_api_method" do
      parser = instance_double("FullCircle::Parsing::ResponseParser",
        parse: double('result', entities: []))
      mock_connection = instance_double("FullCircle::Connection")
      allow(mock_connection).to receive(:call_api_method)

      described_class.new(mock_connection, response_parser: parser).fetch_jobs_for_ad("1", page: 2)
      expect(mock_connection).to have_received(:call_api_method).with("ad.getJobs",{adId: "1", page: 2, resultsPerPage: 20})
    end

    it "returns an array of jobs" do
      VCR.use_cassette "get_jobs_for_ad_response" do
        results = api.fetch_jobs_for_ad "81231"
        expect(results.length > 0).to eq(true)
      end
    end

    context "with no jobs" do
      it "returns an empty array" do
        VCR.use_cassette "empty_get_jobs_response" do
          results = api.fetch_jobs_for_ad "1"
          expect(results.length).to eq(0)
        end
      end
    end
  end

  describe "#fetch_event_areas" do

    it "returns an array of event areas" do
      VCR.use_cassette "event_areas_response" do
        results = api.fetch_event_areas
        expect(results.length > 0).to eq(true)
      end
    end

    context "with no event areas" do
      let(:connection){FullCircle::Connection.new("boatersbluepages.com")}

      it "returns an empty array" do
        VCR.use_cassette "empty_event_area_response" do
          results = api.fetch_event_areas
          expect(results.length).to eq(0)
        end
      end
    end

  end

  describe "#fetch_upcoming_events" do

    it "returns an array of multiple events" do
      VCR.use_cassette "get_upcoming_events_response" do
        results = api.fetch_upcoming_events
        expect(results.length > 1).to eq(true)
      end
    end

    context "with no events" do
      let(:connection){FullCircle::Connection.new("boatersbluepages.com")}
      it "returns an empty array" do
        VCR.use_cassette "empty_get_upcoming_events_response" do
          results = api.fetch_upcoming_events
          expect(results.length).to eq(0)
        end
      end
    end
  end

  describe "#fetch_ads" do

    it "returns an array of ads" do
      VCR.use_cassette "get_ads_response" do
        results = api.fetch_ads.results
        expect(results.length > 1).to eq(true)

        expect(results[0]['tile']['url']).to eq 'http://tours.360durango.com/89540/tile.gif'
        expect(results[0]['logo']['width']).to eq 250
        expect(results[0]['logo2']['height']).to eq 60
      end
    end

    # API server returns an error response instead of an empty array
    context "when no results are found when searching by org id" do

      it "returns_an empty array" do
        VCR.use_cassette "get_ads_with_nonexisted_orgId_response" do
          results = api.fetch_ads(orgId: 1)
          expect(results.length).to eq(0)
        end
      end
    end

    # context "with no events" do
    #   let(:connection){FullCircle::Connection.new("boatersbluepages.com")}
    #   it "returns an empty array" do
    #     VCR.use_cassette "empty_get_upcoming_events_response" do
    #       results = api.fetch_upcoming_events
    #       expect(results).to eq([])
    #     end
    #   end
    # end
  end
end
