require 'spec_helper'

describe FullCircle::Response do

  describe '#results' do
    it 'defaults to an empty array' do
      response = described_class.new([])

      expect(response.results).to eq([])
    end

    it 'can be set to the first argument in the constructor' do
      results = double('results')

      response = described_class.new(results)

      expect(response.results).to eq(results)
    end
  end

end
