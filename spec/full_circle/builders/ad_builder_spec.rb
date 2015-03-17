require 'spec_helper'

module FullCircle

  describe Builders::AdBuilder do
    describe ".build" do
      it "returns a new Ad object" do
        data = {
          "id"=>"81009",
          "name"=>"4Core",
          "url"=>"http://360Durango.com/Environmental/4core.html",
          "eventCount"=>"0",
          "couponCount"=>"0",
          "jobCount"=>"0",
          "locationCount"=>"1",
          "popupCount"=>"0",
          "slideshowCount"=>"0",
          "linkCount"=>"0",
          "address"=>{
            "addr1"=>"949 E 2ND AV",
            "city"=>"DURANGO",
            "state"=>"CO",
            "zipCode"=>"81301"
          }
        }

        ad = described_class.build data

        expected_ad = Ad.new id: 81009,
          name: "4Core",
          url: "http://360Durango.com/Environmental/4core.html",
          event_count: 0,
          coupon_count: 0,
          job_count: 0,
          location_count: 1,
          popup_count: 0,
          slideshow_count: 0,
          link_count: 0,
          address: Address.new(
            addr_1: "949 E 2ND AV",
            city: "DURANGO",
            state: "CO",
            zip_code: "81301"
          )

          expect(ad).to eq(expected_ad)
      end
    end

  end
end
