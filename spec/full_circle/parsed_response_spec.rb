require 'spec_helper'

module FullCircle
  describe ParsedResponse do

    describe "#metadata" do
      context "with provided metadata" do
        let(:xml) do
          <<-"EOS"
        <?xml version="1.0"?>
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

        it 'sets the appropriate kes and values in the hash' do
          response = described_class.new(xml)

          expect(response.metadata).to eq(ResponseMetadata.new({
            page: 2,
            results_per_page: 2,
            total_pages: 541,
            total_results: 1081
          }))
        end
      end

      context "with no provided metadata" do
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
            <coupon id="32025" name="90 for 90!" begin="2013-04-04"
               expire="2013-04-30" accept_offline="1" accept_online="0" acceptMobile="1" acceptPrint="1">
              <offer>Get a relaxing and restorative 90 minute massage for just $90!</offer>
              <restrictions>Service must be booked in the month of April.</restrictions>
            </coupon>
          </coupons>
        </ad-getCouponsResponse>
          EOS
        end

        it 'sets the appropriate kes and values in the hash' do
          response = described_class.new(xml)

          expect(response.metadata).to eq(ResponseMetadata.new({
            page: 1,
            results_per_page: 2,
            total_pages: 1,
            total_results: 2
          }))
        end
      end
    end


    describe "#results" do

      context "with no results" do
        let(:xml) do
          <<-"EOS"
        <?xml version="1.0"?>
        <ad-getCouponsResponse>
          <coupons></coupons>
        </ad-getCouponsResponse>
          EOS
        end

        it 'returns an empty results array' do
          response = described_class.new(xml)

          expect(response.results).to eq([])
        end
      end

      context "with one result" do

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
          response = described_class.new(xml)

          expect(response.results.length).to eq(1)
        end

      end

      context "with multiple results" do
        let(:xml) do
          <<-"EOS"
        <?xml version="1.0"?>
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

        it 'returns an array with all results' do
          response = described_class.new(xml)

          expect(response.results.length).to eq(2)
        end
      end

    end

  end
end
