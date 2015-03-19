require "spec_helper"

describe FullCircle::EndpointIterator do
  describe "#each" do
    (1..5).each { |n| let("result_#{n}".to_sym){ double("result #{n}") } }

    let(:api_client) { instance_double("FullCircle::ApiClient")}

    describe "iteration behavior" do
      it "calls the given method on the api client and yields each result" do
        page_1_metadata = instance_double("FullCircle::ResponseMetadata", has_more_pages?: false)
        page_1_response = FullCircle::Response.new([result_1, result_2], page_1_metadata)
        allow(api_client).to receive(:fetch_ads).with(page: 1).and_return(page_1_response)

        result_set = described_class.new(api_client, :fetch_ads)
        expect{ |b| result_set.each(&b)}.to yield_successive_args(result_1, result_2)
      end

      it "calls the api client's methods until has_more_pages? returns false and yields all results" do
        page_1_metadata = instance_double("FullCircle::ResponseMetadata", has_more_pages?: true)
        page_1_response = FullCircle::Response.new([result_1, result_2, result_3], page_1_metadata)
        allow(api_client).to receive(:fetch_ads).with(page: 1).and_return(page_1_response)

        page_2_metadata = instance_double("FullCircle::ResponseMetadata", has_more_pages?: false)
        page_2_response = FullCircle::Response.new([result_4, result_5], page_2_metadata)
        allow(api_client).to receive(:fetch_ads).with(page: 2).and_return(page_2_response)

        result_set = described_class.new(api_client, :fetch_ads)
        expect{ |b| result_set.each(&b)}.to yield_successive_args(result_1, result_2, result_3, result_4, result_5)
      end

      it "allows additional params to be passed in the constructor and passed along to the api client" do
        page_1_metadata = instance_double("FullCircle::ResponseMetadata", has_more_pages?: true)
        page_1_response = FullCircle::Response.new([result_1, result_2, result_3], page_1_metadata)
        allow(api_client).to receive(:fetch_ads).with(page: 1, orgId: 1).and_return(page_1_response)

        page_2_metadata = instance_double("FullCircle::ResponseMetadata", has_more_pages?: false)
        page_2_response = FullCircle::Response.new([result_4, result_5], page_2_metadata)
        allow(api_client).to receive(:fetch_ads).with(page: 2, orgId: 1).and_return(page_2_response)

        result_set = described_class.new(api_client, :fetch_ads, orgId: 1)
        expect{ |b| result_set.each(&b)}.to yield_successive_args(result_1, result_2, result_3, result_4, result_5)
      end
    end

    describe "parameter passing" do
      let(:page_1_metadata){ instance_double("FullCircle::ResponseMetadata", has_more_pages?: false) }
      let(:page_1_response){ FullCircle::Response.new([], page_1_metadata) }

      it "calls the api client and passes along the hash of parameters" do
        allow(api_client).to receive(:fetch_ads).and_return(page_1_response)

        result_set = described_class.new(api_client, :fetch_ads, orgId: 1)
        result_set.to_a

        expect(api_client).to have_received(:fetch_ads).with({page: 1, orgId: 1})
      end

      it "calls the api client correctly without a hash of parameters" do
        allow(api_client).to receive(:fetch_ads).and_return(page_1_response)

        result_set = described_class.new(api_client, :fetch_ads)
        result_set.to_a

        expect(api_client).to have_received(:fetch_ads).with({page: 1})
      end

      it "calls the api client correctly when an addition parameter given" do
        allow(api_client).to receive(:fetch_events_for_ad).and_return(page_1_response)

        result_set = described_class.new(api_client, :fetch_events_for_ad, 1)
        result_set.to_a

        expect(api_client).to have_received(:fetch_events_for_ad).with(1, {page: 1})
      end

      it "calls the api client correctly additional parameters are given and a hash parameter is given" do
        allow(api_client).to receive(:fetch_events_for_ad).and_return(page_1_response)

        result_set = described_class.new(api_client, :fetch_events_for_ad, 1, {after: :today})
        result_set.to_a

        expect(api_client).to have_received(:fetch_events_for_ad).with(1, {page: 1, after: :today})
      end

    end
  end
end
