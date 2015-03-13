require 'spec_helper'

describe FullCircle::Response do

  describe '#results' do
    it 'defaults to an empty array' do
      response = described_class.new([], {})

      expect(response.results).to eq([])
    end

    it 'can be set to the first argument in the constructor' do
      results = double('results', length: 0)

      response = described_class.new(results, {})

      expect(response.results).to eq(results)
    end
  end

  describe '#page' do
    it 'defaults to 1' do
      response = described_class.new([], {})

      expect(response.page).to eq(1)
    end

    it 'can be set in the metadata hash' do
      response = described_class.new([], {page: 2 })

      expect(response.page).to eq(2)
    end
  end

  describe '#total_pages' do
    it 'defaults to 1' do
      response = described_class.new([], {})

      expect(response.total_pages).to eq(1)
    end

    it 'can be set in the metadata hash' do
      response = described_class.new([], {total_pages: 5 })

      expect(response.total_pages).to eq(5)
    end
  end

  describe '#results_per_page' do
    it 'defaults to 0' do
      response = described_class.new([], {})

      expect(response.results_per_page).to eq(0)
    end

    it 'can be set in the metadata hash' do
      response = described_class.new([], {results_per_page: 5 })

      expect(response.results_per_page).to eq(5)
    end
  end

  describe '#total_results' do
    it 'defaults to 0' do
      response = described_class.new([], {})

      expect(response.total_results).to eq(0)
    end

    it 'can be set in the metadata hash' do
      response = described_class.new([], {total_results: 25 })

      expect(response.total_results).to eq(25)
    end
  end
end
