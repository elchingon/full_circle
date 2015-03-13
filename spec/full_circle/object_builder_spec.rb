require "spec_helper"


describe FullCircle::ObjectBuilder do
  it_behaves_like "an object builder"

  describe "#from_api_hash" do
    let(:builder) { described_class.new}

    it "builds a new event with the appropriate attribute set" do
      object = builder.from_api_hash("id" => "123", "title" => "Hello World")
      object.id.should eq "123"
      object.title.should eq "Hello World"
    end

    it "builds a new event with camelcased attributes converted to underscored attributes" do
      object = builder.from_api_hash("linkUrl" => "http://www.google.com", "siteId" => "77")
      object.link_url.should eq "http://www.google.com"
      object.site_id.should eq "77"
    end

  end
end
