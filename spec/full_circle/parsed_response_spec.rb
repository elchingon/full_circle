require 'spec_helper'

describe FullCircle::ParsedResponse do

  describe "#metadata" do
    context "with provided metadata" do
      let(:xml) do
        <<"EOS"
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

      subject { described_class.new(xml).metadata }

      its([:page]){should eq 2}
      its([:results_per_page]){should eq 2}
      its([ :total_pages ]){should eq 541 }
      its([ :total_results ]){should eq 1081}



    end

    context "with no provided metadata" do
      let (:xml) do
        <<"EOS"
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

      subject { described_class.new(xml).metadata }

      its([ :page ]){should eq 1}
      its([ :total_pages ]){should eq 1 }
      its([ :total_results ]) {should eq 2}
      its([ :results_per_page ]) {should eq 2 }

    end
  end


  describe "#results" do

    context "with no results" do
      let(:xml) do
        <<"EOS"
        <?xml version="1.0"?>
        <ad-getCouponsResponse>
          <coupons></coupons>
        </ad-getCouponsResponse>
EOS
      end

      subject{described_class.new(xml).results}
      it { should eq [] }
    end

    context "with one result" do

      let (:xml) do
        <<"EOS"
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

      subject{described_class.new(xml).results}
      its(:length){should eq 1 }

    end

    context "with multiple results" do
      let(:xml) do
        <<"EOS"
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

      subject { described_class.new(xml).results }

      its(:length){should eq 2}
    end

  end

end
