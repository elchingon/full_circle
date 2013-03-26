require "spec_helper"

describe FullCircle::EventAreaBuilder do

  describe "#from_api_hash" do
    it "builds a new event with the appropriate attribute set" do
      event = described_class.from_api_hash("id" => "123", "name" => "Bayfield")
      event.id.should eq "123"
      event.name.should eq "Bayfield"
    end
  end
end
