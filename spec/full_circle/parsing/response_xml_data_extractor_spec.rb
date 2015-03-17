require 'spec_helper'

describe FullCircle::Parsing::ResponseXMLDataExtractor do

  describe "#extract" do
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

        it 'returns the correct entities hash' do
          response = subject.extract(xml)

          coupon_array = response.entities

          expected_coupon_array = [
            {
              "id"=>"32025",
              "name"=>"90 for 90!",
              "begin"=>"2013-04-04",
              "expire"=>"2013-04-30",
              "accept_offline"=>"1",
              "accept_online"=>"0",
              "acceptMobile"=>"1",
              "acceptPrint"=>"1",
              "offer"=>"Get a relaxing and restorative 90 minute massage for just $90!",
              "restrictions"=>"Service must be booked in the month of April."
            }
          ]

          expect(coupon_array).to eq(expected_coupon_array)
        end

        it 'returns an entity key denoting the root entity type' do
          response = subject.extract(xml)


          expect(response.entity_key).to eq("coupon")
        end

        it 'returns the correct metadata' do
          response = subject.extract(xml)

          expect(response.metadata).to eq(
            FullCircle::ResponseMetadata.new({
              page: 1,
              results_per_page: 1,
              total_pages: 1,
              total_results: 1
            })
          )
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

        it 'returns the correct entities hash' do
          response = subject.extract(xml)

          ad_array = response.entities

          expected_ad_array = [
            {
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
          ]

          expect(ad_array).to eq(expected_ad_array)
        end

        it 'returns the correct metadata' do
          response = subject.extract(xml)

          expect(response.metadata).to eq(
            FullCircle::ResponseMetadata.new({
              page: 2,
              results_per_page: 1,
              total_pages: 541,
              total_results: 541
            })
          )
        end
      end

      context "with multiple results" do

        context "and provided metadata" do

          let (:xml) do
            <<-EOS
          <ad-getListResponse page="2" resultsPerPage="2" totalPages="541" totalResults="1081">
            <ads>
              <ad id="81009" name="4Core" url="http://360Durango.com/Environmental/4core.html"
                eventCount="0" couponCount="0" jobCount="0" locationCount="1" popupCount="0"
                slideshowCount="0" linkCount="0">
                  <address addr1="949 E 2ND AV" city="DURANGO" state="CO" zipCode="81301"></address>
              </ad>
              <ad id="123760" name="4x4 Auto " url="http://360Durango.com/Automotive/4x4Auto.html"
                description="Used Car Dealership Cortez 360Durango Colorado" eventCount="0"
                couponCount="0" jobCount="0" locationCount="0" popupCount="0" slideshowCount="0"
                linkCount="0">
              </ad>
            </ads>
          </ad-getListResponse>
            EOS
          end

          it 'returns the correct entities array of hashes' do
            response = subject.extract(xml)

            ad_array = response.entities

            expected_ad_array = [
              {
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
              },
              {
                "id"=>"123760",
                "name"=>"4x4 Auto ",
                "url"=>"http://360Durango.com/Automotive/4x4Auto.html",
                "description"=>"Used Car Dealership Cortez 360Durango Colorado",
                "eventCount"=>"0",
                "couponCount"=>"0",
                "jobCount"=>"0",
                "locationCount"=>"0",
                "popupCount"=>"0",
                "slideshowCount"=>"0",
                "linkCount"=>"0"
              }
            ]

            expect(ad_array).to eq(expected_ad_array)
          end

          it 'returns the correct metadata' do
            response = subject.extract(xml)

            expect(response.metadata).to eq(
              FullCircle::ResponseMetadata.new({
                page: 2,
                results_per_page: 2,
                total_pages: 541,
                total_results: 1081
              })
            )
          end
        end
      end

      context "with no results" do

        context "with no metadata" do
          let(:xml) do
            <<-"EOS"
              <?xml version="1.0"?>
              <ad-getCouponsResponse>
                <coupons></coupons>
              </ad-getCouponsResponse>
            EOS
          end

          it 'returns an empty results array' do
            response = subject.extract(xml)

            expect(response.entities).to eq([])
          end

          it 'returns an entity key denoting the root entity type' do
            response = subject.extract(xml)


            expect(response.entity_key).to eq("coupon")
          end
        end

        context "with metadata" do
          let(:xml) do
            <<-"EOS"
              <?xml version="1.0"?>
              <ad-getCouponsResponse page="1" resultsPerPage="20" totalPages="0" totalResults="0">
                <coupons></coupons>
              </ad-getCouponsResponse>
            EOS
          end

          it 'returns an empty results array' do
            response = subject.extract(xml)

            expect(response.entities).to eq([])
          end

          it 'returns an entity key denoting the root entity type' do
            response = subject.extract(xml)


            expect(response.entity_key).to eq("coupon")
          end

          it 'returns the correct metadata' do
            response = subject.extract(xml)

            expect(response.metadata).to eq(
              FullCircle::ResponseMetadata.new({
                page: 1,
                results_per_page: 20,
                total_pages: 0,
                total_results: 0
              })
            )
          end
        end
      end

      context "with an error response" do
        let(:xml) do
          <<-EOS
          <errorResponse methodGroup="ad" methodName="getList">
            <errorCode>1203</errorCode>
            <errorDetails>
              Encountered error while retrieving necessary method information from database.
            </errorDetails>
          </errorResponse>
          EOS
        end

        it 'returns an empty results array' do
          response = subject.extract(xml)

          expect(response.entities).to eq([])
        end

        it 'returns the correct metadata' do
          response = subject.extract(xml)

          expect(response.metadata).to eq(
            FullCircle::ResponseMetadata.new({
              page: 1,
              results_per_page: 0,
              total_pages: 0,
              total_results: 0
            })
          )
        end

      end
    end
  end
end
