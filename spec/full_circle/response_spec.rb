require 'spec_helper'

module FullCircle
  describe Response do
    let(:fake_result_1){double "fake result 1"}
    let(:fake_result_2){double "fake result 2"}
    let(:results){[fake_result_1, fake_result_2]}
    let(:metadata){ResponseMetadata.new page: 1, results_per_page: 20,
                   total_pages: 2, total_results: 37 }

    describe "#metadata" do
      it "is set through the constructor" do
        response = described_class.new results, metadata

        expect(response.metadata).to eq(metadata)
      end
    end

    describe "#results" do
      it "is set through the constructor" do
        response = described_class.new results, metadata

        expect(response.results).to eq(results)
      end
    end

    describe "#each" do
      it "yields each result in the results array" do
        response = described_class.new results, metadata

        expect{ |b| response.each(&b)}.to yield_successive_args(fake_result_1, fake_result_2)
      end
    end

    describe "#count" do
      it "returns the number of results in the results array" do
        response = described_class.new results, metadata

        expect(response.count).to eq(2)
      end
    end

    describe "delegated methods" do
      subject{ described_class.new results, metadata }

      it{should delegate_method(:length).to(:results)}

      it{should delegate_method(:page).to(:metadata)}
      it{should delegate_method(:total_pages).to(:metadata)}
      it{should delegate_method(:results_per_page).to(:metadata)}
      it{should delegate_method(:total_results).to(:metadata)}
      it{should delegate_method(:has_more_pages?).to(:metadata)}
    end
  end
end
