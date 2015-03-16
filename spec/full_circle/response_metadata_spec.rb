require 'spec_helper'

describe FullCircle::ResponseMetadata do
  describe '#page' do
    it "defaults to 1" do
      metadata = described_class.new
      expect(metadata.page).to eq(1)
    end

    it "allows the value to be set in the constructor" do
      metadata = described_class.new page: "2"
      expect(metadata.page).to eq(2)
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

  describe "#has_more_pages?" do
    it "returns true if page < total_pages" do
      metadata = described_class.new page: 1, total_pages: 5
      expect(metadata).to have_more_pages
    end

    it "returns false if page == total_pages" do
      metadata = described_class.new page: 5, total_pages: 5
      expect(metadata).not_to have_more_pages
    end
  end
end
