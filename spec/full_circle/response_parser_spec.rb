require 'spec_helper'

module FullCircle
  describe ResponseParser do

    describe "#parse" do

      context "with one result"  do

        context "with no metadata" do
          let (:xml) do
            <<-"EOS"
        <?xml version="1.0"?>
        <ad-getCouponsResponse>
          <coupons>
            <coupon id="32025" name="90 for 90!" begin="2013-04-04"
               expire="2013-04-30" accept_offline="1" accept_online="0" acceptMobile="1" acceptPrint="1">
              <offer>Get a relaxing and restorative 90 minute massage for just $90!</offer>
              <restrictions>Service must be booked in the month of April.</restrictions>
            </coupon>
          </coupons>
        </ad-getCouponsResponse>
            EOS
          end

          it 'returns one object in the results array' do
            response = subject.parse xml

            expect(response.length).to eq(1)
          end

          it 'returns an object parsed into the correct object' do
            response = subject.parse(xml)

            coupon = response.first

            expected_coupon = Coupon.new id: 32025,
              name: "90 for 90!",
              begin: Date.new(2013, 04, 04),
              expire: Date.new(2013, 04, 30),
              accept_offline: true,
              accept_online: false,
              accept_mobile: true,
              accept_print: true,
              offer: "Get a relaxing and restorative 90 minute massage for just $90!",
              restrictions: "Service must be booked in the month of April."

            expect(coupon).to eq(expected_coupon)
          end
        end

        context "with metadata" do

          let (:xml) do
            <<-EOS
            <ad-getListResponse page="2" resultsPerPage="1" totalPages="541" totalResults="541">
              <ads>
                <ad id="81009" name="4Core" url="http://360Durango.com/Environmental/4core.html"
                  eventCount="0" couponCount="0" jobCount="0" locationCount="1" popupCount="0"
                  slideshowCount="0" linkCount="0">
                    <address addr1="949 E 2ND AV" city="DURANGO" state="CO" zipCode="81301"></address>
                </ad>
              </ads>
            </ad-getListResponse>
            EOS
          end

          it 'returns one object in the results array' do
            response = subject.parse xml

            expect(response.length).to eq(1)
          end

          it 'returns an object parsed into the correct object' do
            response = subject.parse(xml)

            ad = response.first

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

        context "when no results" do
          it "returns a response with an empty array of results" do
            mock_response = double("response", entities: [],
                                   entity_key: nil, metadata: double("metadata"))
            extractor = instance_double "FullCircle::Parsing::ResponseXMLDataExtractor",
              extract: mock_response
            parser = described_class.new data_extractor: extractor

            response = parser.parse("<html></html>")

            expect(response.results).to eq([])
          end
        end
      end
    end
  end
end
