require 'spec_helper'

module FullCircle
  describe Builders::EventAreaBuilder do
    describe ".build" do
      it "returns a new Event object" do
        data = {
          "id"=>"736",
          "name"=>"Bayfield"
        }

        event_area = described_class.build data

        expected_event_area = EventArea.new id: 736,
          name: "Bayfield"

        expect(event_area).to eq(expected_event_area)
      end
    end

  end
end
