require "spec_helper"

describe FullCircle::UpcomingEventBuilder do
  it_behaves_like "an object builder"

  describe "event output" do
    let(:api_hash) do
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
    end

    subject {described_class.new.from_api_hash(api_hash)}

    it_behaves_like "an event"
  end
end
