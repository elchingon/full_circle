require 'spec_helper'

describe FullCircle::ResponseMetadata do
  describe '#pages' do
    it "defaults to 1" do
      metadata = described_class.new
      expect(metadata.pages).to eq(1)
    end

    it "allows the value to be set in the constructor" do
      metadata = described_class.new pages: "2"
      expect(metadata.pages).to eq(2)
    end
  end

  describe '#results_per_page' do
    it "defaults to 1" do
      metadata = described_class.new
      expect(metadata.results_per_page).to eq(1)
    end

    it "allows the value to be set in the constructor" do
      metadata = described_class.new results_per_page: "5"
      expect(metadata.results_per_page).to eq(5)
    end
  end

  describe '#total_results' do
    it "defaults to 0" do
      metadata = described_class.new
      expect(metadata.total_results).to eq(0)
    end

    it "allows the value to be set in the constructor" do
      metadata = described_class.new total_results: "5"
      expect(metadata.total_results).to eq(5)
    end
  end

  describe '#total_pages' do
    it "defaults to 0" do
      metadata = described_class.new
      expect(metadata.total_pages).to eq(0)
    end

    it "allows the value to be set in the constructor" do
      metadata = described_class.new total_pages: "5"
      expect(metadata.total_pages).to eq(5)
    end
  end
end
