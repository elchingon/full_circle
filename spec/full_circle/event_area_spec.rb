require "spec_helper"

describe FullCircle::EventArea do
  
  describe "#initialize" do
    it "should set instance variables based on the hash passed in" do
      event_area = described_class.new "id" => "736", "name" => "Bayfield"
      event_area.id.should eq "736"
      event_area.name.should eq "Bayfield" 
    end
  end
end
