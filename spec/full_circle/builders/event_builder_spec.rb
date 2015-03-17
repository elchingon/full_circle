require 'spec_helper'

module FullCircle
  describe Builders::EventBuilder do
    describe ".build" do
      it "returns a new Event object" do
        data = {
          "id"=>"42880",
          "date"=>"2015-03-16",
          "expireDate"=>"2015-12-28",
          "endDate"=>"2015-12-18",
          "time"=>"16:00:00",
          "endTime"=>"19:00:00",
          "title"=>"Fish & Chips Special",
          "allDayEvent"=>"1",
          "times_vary"=>"0",
          "location"=>"The Irish Embassy Pub",
          "type"=>"Food / Beverage Specials",
          "dateMode"=>"4",
          "siteId"=>"77",
          "price"=>"$4 off",
          "linkText"=>"Click Here for More Info",
          "linkUrl"=>"http://www.theirishembassypub.com",
          "featured"=>"0",
          "description"=>"Fish & Chips Special - $4 off full order all day",
          "imageURL"=>"http://tours.360durango.com/89690/events/42880.jpg",
          "url"=>"fish-chips-special"
        }

        event = described_class.build data

        expected_event = Event.new id: 42880,
          date: Date.new(2015,03,16),
          expire_date: Date.new(2015, 12, 28),
          end_date: Date.new(2015, 12, 18),
          time: "16:00:00",
          end_time: "19:00:00",
          title: "Fish & Chips Special",
          all_day_event: true,
          times_vary: false,
          location: "The Irish Embassy Pub",
          type: "Food / Beverage Specials",
          date_mode: 4,
          site_id: 77,
          price: "$4 off",
          link_text: "Click Here for More Info",
          link_url: "http://www.theirishembassypub.com",
          featured: false,
          description: "Fish & Chips Special - $4 off full order all day",
          image_url: "http://tours.360durango.com/89690/events/42880.jpg",
          url: "fish-chips-special"

        expect(event).to eq(expected_event)
      end

      it "returns a new Event object" do
        data = {
          "id"=>"42880",
          "date"=>"2015-03-16",
          "expireDate"=>"2015-12-28",
          "time"=>"16:00:00",
          "endTime"=>"19:00:00",
          "title"=>"Fish & Chips Special",
          "allDayEvent"=>"0",
          "times_vary"=>"0",
          "location"=>"The Irish Embassy Pub",
          "type"=>"Food / Beverage Specials",
          "dateMode"=>"4",
          "siteId"=>"77",
          "price"=>"$4 off",
          "linkText"=>"Click Here for More Info",
          "linkUrl"=>"http://www.theirishembassypub.com",
          "featured"=>"0",
          "description"=>"Fish & Chips Special - $4 off full order all day",
          "imageURL"=>"http://tours.360durango.com/89690/events/42880.jpg",
          "url"=>"fish-chips-special"
        }

        event = described_class.build data

        expected_event = Event.new id: 42880,
          date: Date.new(2015,03,16),
          expire_date: Date.new(2015, 12, 28),
          time: "16:00:00",
          end_time: "19:00:00",
          title: "Fish & Chips Special",
          all_day_event: false,
          times_vary: false,
          location: "The Irish Embassy Pub",
          type: "Food / Beverage Specials",
          date_mode: 4,
          site_id: 77,
          price: "$4 off",
          link_text: "Click Here for More Info",
          link_url: "http://www.theirishembassypub.com",
          featured: false,
          description: "Fish & Chips Special - $4 off full order all day",
          image_url: "http://tours.360durango.com/89690/events/42880.jpg",
          url: "fish-chips-special"

        expect(event).to eq(expected_event)
      end
    end

  end
end
