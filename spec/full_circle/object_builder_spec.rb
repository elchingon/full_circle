require "spec_helper"


describe FullCircle::ObjectBuilder do
  it_behaves_like "an object builder"

  describe "#from_api_hash" do
    let(:builder) { described_class.new}

    it "builds a new event with the appropriate attribute set" do
      object = builder.from_api_hash("id" => "123", "title" => "Hello World")
      expect(object.id).to eq("123")
      expect(object.title).to eq("Hello World")
    end

    it "builds a new event with camelcased attributes converted to underscored attributes" do
      object = builder.from_api_hash("linkUrl" => "http://www.google.com", "siteId" => "77")
      expect(object.link_url).to eq("http://www.google.com")
      expect(object.site_id).to eq("77")
    end

  end
end
