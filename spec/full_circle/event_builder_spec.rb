require "spec_helper"

describe FullCircle::EventBuilder do

  describe "#from_api_hash" do
    it "builds a new event with the appropriate attribute set" do
      event = described_class.from_api_hash("id" => "123", "title" => "Hello World")
      event.id.should eq "123"
      event.title.should eq "Hello World"
    end
    
    it "builds a new event with camelcased attributes converted to underscored attributes" do
      event = described_class.from_api_hash("linkUrl" => "http://www.google.com", "siteId" => "77")
      event.link_url.should eq "http://www.google.com"
      event.site_id.should eq "77"
    end

  end
end
