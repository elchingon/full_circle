require "spec_helper"

describe FullCircle::EndpointIterator do
  describe "#each" do
    (1..5).each { |n| let("result_#{n}".to_sym){ double("result #{n}") } }

    let(:api_client) { instance_double("FullCircle::ApiClient")}

    it "calls the given method on the api client and yields each result" do
      page_1_metadata = instance_double("FullCircle::ResposneMetadata", has_more_pages?: false)
      page_1_response = FullCircle::Response.new([result_1, result_2], page_1_metadata)
      allow(api_client).to receive(:fetch_ads).with(page: 1).and_return(page_1_response)

      result_set = described_class.new(api_client, :fetch_ads)
      expect{ |b| result_set.each(&b)}.to yield_successive_args(result_1, result_2)
    end

    it "calls the api client's methods until has_more_pages? returns false and yields all results" do
      page_1_metadata = instance_double("FullCircle::ResposneMetadata", has_more_pages?: true)
      page_1_response = FullCircle::Response.new([result_1, result_2, result_3], page_1_metadata)
      allow(api_client).to receive(:fetch_ads).with(page: 1).and_return(page_1_response)

      page_2_metadata = instance_double("FullCircle::ResposneMetadata", has_more_pages?: false)
      page_2_response = FullCircle::Response.new([result_4, result_5], page_2_metadata)
      allow(api_client).to receive(:fetch_ads).with(page: 2).and_return(page_2_response)

      result_set = described_class.new(api_client, :fetch_ads)
      expect{ |b| result_set.each(&b)}.to yield_successive_args(result_1, result_2, result_3, result_4, result_5)
    end

    it "allows additional params to be passed in the constructor and passed along to the api client" do
      page_1_metadata = instance_double("FullCircle::ResposneMetadata", has_more_pages?: true)
      page_1_response = FullCircle::Response.new([result_1, result_2, result_3], page_1_metadata)
      allow(api_client).to receive(:fetch_ads).with(page: 1, orgId: 1).and_return(page_1_response)

      page_2_metadata = instance_double("FullCircle::ResposneMetadata", has_more_pages?: false)
      page_2_response = FullCircle::Response.new([result_4, result_5], page_2_metadata)
      allow(api_client).to receive(:fetch_ads).with(page: 2, orgId: 1).and_return(page_2_response)

      result_set = described_class.new(api_client, :fetch_ads, orgId: 1)
      expect{ |b| result_set.each(&b)}.to yield_successive_args(result_1, result_2, result_3, result_4, result_5)
    end
  end
end
