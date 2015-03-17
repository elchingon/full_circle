require "spec_helper"

module FullCircle
  describe Builders::UpcomingEventBuilder do

    describe ".build" do
      it "correctly builds an Event object"  do
        data =
          {
          "id" => "51019",
          "date" => "2013-04-22",
          "expireDate" => "2013-06-24",
          "time" => "16:00:00",
          "endTime" => "22:00:00",
          "title" => "Burger Nite",
          "allDayEvent" => "0",
          "type" => "Food Special",
          "dateMode" => "4",
          "siteId" => "77",
          "price" => "$4.95",
          "linkText" => "Like us on Facebook!",
          "linkUrl" => "https://www.facebook.com/pages/Olde-Tymers-Cafe/107138292687599",
          "featured" => "1",
          "ad" => {
            "id" => "81277",
            "name" => "Olde Tymers Cafe",
            "url" => "http://360Durango.com/Attractions/oldetymerscafe.html",
            "description" => "Downtown Durango's Best Burger Cafe with Outdoor Patio!",
            "eventCount" => "6",
            "couponCount" => "0",
            "jobCount" => "0",
            "locationCount" => "1",
            "popupCount" => "0",
            "slideshowCount" => "2",
            "linkCount" => "2",
            "address" => {
              "addr1" => "1000 Main Avenue",
              "city" => "Durango",
              "state" => "CO",
              "zipCode" => "81301",
              "phone" => "970.259.2990"
            }
          },
          "__content__" => "Since 1981 Olde Tymers Cafe has been bringing people together with a relaxing atmosphere, great food, and libations."
        }

        event = described_class.build(data)

        expectedEvent = Event.new(
          id: 51019,
          date: Date.new(2013, 04, 22),
          expire_date: Date.new(2013, 06, 24),
          time: "16:00:00",
          end_time: "22:00:00",
          title: "Burger Nite",
          all_day_event: false,
          type: "Food Special",
          date_mode: 4,
          site_id: 77,
          price: "$4.95",
          link_text: "Like us on Facebook!",
          link_url: "https://www.facebook.com/pages/Olde-Tymers-Cafe/107138292687599",
          featured: true,
          description: "Since 1981 Olde Tymers Cafe has been bringing people together with a relaxing atmosphere, great food, and libations.",
          ad_id: 81277
        )

        expect(event).to eq(expectedEvent)
      end
    end
  end
end
