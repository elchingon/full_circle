require 'spec_helper'

describe FullCircle::APIFactory do
  describe "#create" do
    it "creates a new api client and connection with the arguments passed in" do
      factory = described_class.new
      cache = double "cache"

      api_client = factory.create("360durango.com", cache: cache)

      connection= api_client.connection

      expect(connection.domain).to eq("360durango.com")
      expect(connection.cache).to eq(cache)
    end
  end
end
